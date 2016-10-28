class ComputeCommentStats

  def initialize(comments, issue_comments)
    @comments = comments
    @issue_comments = issue_comments
  end

  def merged_comments
    merged_comments = @comments += @issue_comments
  end

  def get_commenter_user_names
    merged_comments.map { |c| c[:user][:login] }.uniq
  end

  def get_comments_by_user(get_commenter_user_names)
    array = []
    get_commenter_user_names.each do |u|
      user_array = []
      merged_comments.each do |c|
        user_array << c if c[:user][:login] == u
      end
      array << user_array
    end
    array
  end

  def remove_duplicate_pull_requests
    array = []
    get_comments_by_user(get_commenter_user_names).each do |comments|
      pr = comments.uniq do |c|
        c[:pull_request_url]
      end
      this = comments.uniq do |c|
        c[:issue_url]
      end
      array << [this[0][:user][:login], (pr.count + this.count)]
    end
    array
  end
end
