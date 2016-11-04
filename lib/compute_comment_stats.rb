class ComputeCommentStats

  USERS = ['gbkr', 'mottalrd', 'katebeavis', 'TomGroombridge']

  def initialize(merged_comments)
    @merged_comments = merged_comments
  end

  def comment_authors
    @merged_comments.map { |c| c[:user][:login] }.uniq
  end

  def get_comments_by_user(users)
    comment_authors.each_with_object([]) do |user, array|
      array << @merged_comments.each_with_object([]) {
        |c, user_array| user_array << c if c[:user][:login] == user
      }
    end
  end

  def comments_made_by_user(time_period, remove_duplicates)
    get_comments_by_user(comment_authors).each_with_object([]) do |comments, array|
      comments_by_time_period = select_comments_based_on_time_period(comments, time_period)
      comment_count = remove_duplicates ? remove_duplicate_comments(comments_by_time_period) : comments_by_time_period.count
      array << [comments[0][:user][:login], comment_count] if USERS.include? comments[0][:user][:login]
    end
  end

  def remove_duplicate_comments(comments_by_time_period)
    urls = prepare_url_string(comments_by_time_period)
    comments_by_time_period.count - number_of_duplicate_urls(urls)
  end

  def anonymised_contribution_data(time_period)
    randomise_names(comments_made_by_user(time_period, true))
  end

  def select_comments_based_on_time_period(comments, time_period)
    comments.select { |c| c[:created_at] >= time_period}
  end

  def prepare_url_string(comments)
    comments.map { |c| c[:html_url].partition('#').first }
  end

  def number_of_duplicate_urls(urls)
    duplicate_urls = urls.select { |url| urls.count(url) > 1 }
    duplicate_urls.count - duplicate_urls.uniq.count
  end

  def randomise_names(user_array)
    letter = 'A'
    user_array.each { |name, amount|
      name.replace(letter)
      letter = letter.next
    }
  end

  def avg(time_period)
    values = comments_made_by_user(time_period, true).map { |v| v[1] }
    values.inject(:+) / values.count
  end

  def below_avg(time_period)
    avg(time_period) / 2
  end

  def above_avg(time_period)
    avg(time_period) * 2
  end

  def below_average_team_members(time_period)
    user_array = comments_made_by_user(time_period, true).map! { |v| v[1] if v[1] <= below_avg(time_period) }.compact
    user_array.count
  end

  def above_average_team_members(time_period)
    user_array = comments_made_by_user(time_period, true).map! { |v| v[1] if v[1] >= above_avg(time_period) }.compact
    user_array.count
  end
end
