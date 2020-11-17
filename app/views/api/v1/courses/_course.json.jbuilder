json.extract! course, :id, :title, :description, :author_id
json.created_at course.created_at.utc.to_s
