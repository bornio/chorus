class WorkfileVersion < ActiveRecord::Base
  attr_accessible :commit_message, :owner, :modifier, :contents, :version_num
  has_attached_file :contents, :styles => {:original => "", :icon => "50x50>"}
  belongs_to :workfile
  belongs_to :owner, :class_name => 'User'
  belongs_to :modifier, :class_name => 'User'
  before_post_process :check_file_type

  def check_file_type
    image?
  end

  CODE_EXTENSIONS = ["cpp", "r"]

  def extension
    File.extname(contents.original_filename)[1..-1].try(:downcase)
  end

  def file_type
    if image?
      "image"
    elsif code?
      "code"
    elsif sql?
      "sql"
    elsif text?
      "text"
    else
      "other"
    end
  end

  def image?
    content_type && content_type.include?('image')
  end

  def text?
    content_type && content_type.include?('text')
  end

  def sql?
    extension == "sql"
  end

  def code?
    CODE_EXTENSIONS.include?(extension)
  end

  def content_type
    contents.content_type
  end
end