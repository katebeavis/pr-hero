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
      pr = remove_duplicate_pull_requests(comments)
      urls = prepare_url_string(pr)
      dup_issues = remove_duplicate_urls(urls)
      array << [pr[0][:user][:login], (pr.count - dup_issues.count)] if USERS.include? pr[0][:user][:login]
    end
    array
  end

  def remove_duplicate_pull_requests(comments)
    comments.uniq { |c| [c[:pull_request_url], c[:issue_url]] }
  end

  def prepare_url_string(pr)
    pr.map { |c| c[:html_url].partition('#').first }
  end

  def remove_duplicate_urls(urls)
    urls.select { |url| urls.count(url) > 1 }.uniq
  end
end
