class ComputeCommentStats

  USERS = ['gbkr', 'mottalrd', 'katebeavis', 'TomGroombridge']

  def initialize(comments, issue_comments)
    @comments = comments
    @issue_comments = issue_comments
    @merged_comments = (@comments << @issue_comments).flatten!
  end

  def comment_authors
    @merged_comments.map { |c| c[:user][:login] }.uniq
  end

  def get_comments_by_user(comment_authors)
    array = []
    comment_authors.each do |u|
      user_array = []
      @merged_comments.each { |c| user_array << c if c[:user][:login] == u }
      array << user_array
    end
    array
  end

  def number_of_prs_contributed_to
    array = []
    get_comments_by_user(comment_authors).each do |comments|
      urls = prepare_url_string(comments)
      num_of_dup_issues = find_duplicate_urls(urls)
      array << [comments[0][:user][:login], (comments.count - num_of_dup_issues)] if USERS.include? comments[0][:user][:login]
    end
    array
  end

  def prepare_url_string(comments)
    comments.map { |c| c[:html_url].partition('#').first }
  end

  def find_duplicate_urls(urls)
    duplicate_urls = urls.select { |url| urls.count(url) > 1 }
    return duplicate_urls.count - duplicate_urls.uniq.count
  end
end
