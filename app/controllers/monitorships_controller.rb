class MonitorshipsController < ApplicationController
  before_filter :login_required

  def create
		@forum = Forum.find_by_permalink(params[:forum_id])
		@topic = Topic.find_by_permalink(params[:topic_id])
    @monitorship = Monitorship.find_or_initialize_by_user_id_and_topic_id(current_user.id, @topic)
    @monitorship.update_attribute :active, true
    respond_to do |format| 
      format.html { redirect_to forum_topic_path(@forum, @topic) }
      format.js
    end
  end
  
  def destroy
		@forum = Forum.find_by_permalink(params[:forum_id])
		@topic = Topic.find_by_permalink(params[:topic_id])
    Monitorship.update_all ['active = ?', false], ['user_id = ? and topic_id = ?', current_user.id, @topic]
    respond_to do |format| 
      format.html { redirect_to forum_topic_path(@forum, @topic) }
      format.js
    end
  end
end