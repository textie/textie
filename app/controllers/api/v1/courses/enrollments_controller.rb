class EnrollmentsController < ApplicationController
  expose :course
  expose :enrollment, parent: :course

  def show
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)

    if @enrollment.save
      render :show, status: :created, location: @enrollment
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @enrollment.update(enrollment_params)
      render :show, status: :ok, location: @enrollment
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @enrollment.destroy
  end

  private

  def enrollment_params
    params.fetch(:enrollment, {})
  end
end
