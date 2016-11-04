class RecommendedReviewer

  def initialize(comment_stats)
    @comment_stats = comment_stats
  end

  def get_recommended_reviewer
    @comment_stats.comments_made_by_user(7.days.ago).min_by{|k,v| v}[0]
  end

  def hipchat_username
    case get_recommended_reviewer
    when 'gbkr'
      '@GregBaker'
    when 'mottalrd'
      '@AlfredoMotta'
    when 'katebeavis'
      '@KateBeavis'
    when 'TomGroombridge'
      '@TomGroombridge'
    else
      'Hipchat username could not be found'
    end
  end
end
