class ContainerComplianceService
  include UiServiceMixin
  CPU_USAGE_PRECISION = 2 # 2 decimal points

  def initialize(provider_id, controller)
    @provider_id = provider_id
    @ems = ManageIQ::Providers::ContainerManager.find(@provider_id) unless @provider_id.blank?
    @controller = controller
  end

  def all_data
    {
        :daily_image_metrics    => daily_image_metrics
    }.compact
  end

  def daily_image_metrics
    # image_matrix: Divide the set of container images to disjoint groups:
    image_matrix = [
      :high_severity_scap_infringers   => ContainerImage.first,
      :medium_severity_scap_infringers => ContainerImage.second,
      :low_severity_scap_infringers    => ContainerImage.second,
      :no_violation_and_no_scap_data   => 0,
      :no_violation_with_scap_data     => 0,
    ]
    # image_matrix = {}
    # all_images = ContainerImage.all # filter by provider
    # image_matrix[:high_severity_scap_infringers] = all_images.
    # no_data = ContainerImage.where('id NOT IN (SELECT DISTINCT(container_image_id) FROM openscap_results)')
    # # ContainerImage.joins(:openscap_result => :openscap_rule_results).where(:openscap_rule_results.result = 'fail')
    # ContainerImage.
    # select("container_image.id, Distinct(openscap_rule_result.result), Distinct(openscap_rule_result.severity)")
    # .joins("LEFT JOIN openscap_results ON openscap_results.container_image_id = container_images.id")
    # .joins("LEFT JOIN openscap_rule_results ON openscap_rule_results.openscap_result_id = openscap_results.id")
    # .group("container_image.id, openscap_rule_result.result, openscap_rule_result.severity")

    # sql = "SELECT container_images.id, openscap_rule_results.severity FROM container_images INNER JOIN openscap_results ON openscap_results.container_image_id = container_images.id INNER JOIN openscap_rule_results ON openscap_rule_results.openscap_result_id = openscap_results.id WHERE openscap_rule_results.result = 'fail'  GROUP BY openscap_rule_results.severity, container_images.id;"
    # container_image_severities = {}
    # ActiveRecord::Base.connection.execute(sql).each do |res|
    #
    #   container_image_severities[res['id']] ||= []
    #   container_image_severities[res['id']] << res['severity']
    {
      "heatmaps" => {
        "containerCompliance" =>
        [
          {
            "id"              => 1,
            "name"            => "nginx",
            "provider"        => "Molecule",
            "highestSecerity" => 3
          },
          {
            "id"              => 1,
            "name"            => "nginx",
            "provider"        => "Molecule",
            "highestSecerity" => 3
          },
          {
            "id"              => 1,
            "name"            => "nginx",
            "provider"        => "Molecule",
            "highestSecerity" => 3
          },
          {
            "id"              => 1,
            "name"            => "nginx",
            "provider"        => "Molecule",
            "highestSecerity" => 3
          },
          {
            "id"              => 1,
            "name"            => "nginx",
            "provider"        => "Molecule",
            "highestSecerity" => 3
          }
        ]
      },
      "images" => {
        "total" => 5,
        "high_severity_scap_infringers"   => 1,
        "medium_severity_scap_infringers" => 1,
        "low_severity_scap_infringers"    => 1,
        "no_violation_with_scap_data"     => 1,
        "no_violation_and_no_scap_data"   => 1
      }
    }
  end

  #   all_images.each do |image|
  #     img = "#{image.name}-#{image.id}"
  #     if !container_image_severities.key?(image) && no_data.include?
  #       image_matrix[:no_violation_and_no_scap_data] << img
  #     elsif !container_image_severities.key?(image)
  #       image_matrix[:no_violation_with_scap_data] << img
  #     elsif container_image_severities[image.id].include?("High")
  #       image_matrix[:high_severity_scap_infringers] << img
  #     elsif container_image_severities[image.id].include?("Medium")
  #       image_matrix[:medium_severity_scap_infringers] << img
  #     elsif container_image_severities[image.id].include?("Low")
  #       image_matrix[:low_severity_scap_infringers] << img
  #     end
  #   end
  # end
end
