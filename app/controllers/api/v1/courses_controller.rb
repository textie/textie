class CoursesController < ApplicationController
  expose :course
  expose :courses

  def index
  end

  def show
  end

  def create
    result = CreateCourse.call(user: current_user, course: course)

    if result.success
      render :show, status: :created, location: result.course
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def update
    if course.update(course_params)
      render :show, status: :ok, location: course
    else
      render json: course.errors, status: :unprocessable_entity
    end
  end

  def destroy
    course.destroy
  end

  private

  def course_params
    params.require(:course).permit(:title, :description)
  end
end
