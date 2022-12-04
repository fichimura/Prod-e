class StaticPagesController < ApplicationController

    skip_before_action :authenticate_user!, :only => [:landing_page]
    
    def landing_page
        @courses = Course.all.limit(3)
        @latest_couses = Course.all.limit(3).order(created_at: :desc)
        @latest_good_reviews = Enrollment.reviewed.order(avaliacao: :desc, created_at: :desc).limit(3)
        @top_rated_courses = Course.order(avaliacao_media: :desc, created_at: :desc).limit(3)
        @enrolled_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).order(created_at: :desc).limit(3)
    end

    def activity
        @activities = PublicActivity::Activity.all
    end
  
end