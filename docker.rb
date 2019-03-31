require 'json'

require_relative 'docker/imageListFilter'

class Docker
  def take_image(image, version = "latest")
    return DockerImage.new(image, version)
  end

  def image_list(filter = "")
    `docker image ls --digests --format '{{json .}}' #{filter}`.each_line.map do |line|
      JSON.parse(line)
    end
  end

  def pull_all(name)
    `docker image pull -a #{name}`
  end

  # TODO: support option --filter
  # TODO: support option --limit
  def search_image(name)
    `docker search #{name}`
  end

  def image_inspect(name)
    JSON.parse(`docker image inspect #{name}`)
  end

  def image_remove(name)
    JSON.parse(`docker image rm #{name}`)
  end

  def image_remove_all_force
    `docker image rm $(docker image ls -q) -f`
  end

end



class DockerImage
  def initialize(name, version)
    @name = name
    @version = version
    @full_name = "#{name}:#{version}"
  end

  def pull
    `docker image pull #{@full_name}`
  end

  def remove
    `docker image rm #{@full_name}`
  end

  def create_container
    id = `docker run -d #{@full_name}`.strip
    DockerContainer.new(id)
  end

  def inspect
    JSON.parse(`docker image inspect #{@full_name}`)
  end

end

class DockerContainer
  def initialize(id)
    @id = id
  end

  def execute_command(command)
    `docker exec -it #{@id} #{command}`
  end
end


docker = Docker.new

image = docker.take_image("redis", "2-32bit")

# var2 = ImageListFilterBuilder.new.with_before("4161e91dcc29").get

# container = image.create_container
# puts container.execute_command("pwd")
list = docker.image_remove_all_force
list = docker.image_list
# list.each do |img|
# list.each do |img|
#   docker.take_image(img["Repository"], img["Tag"]).remove
# end
puts list



