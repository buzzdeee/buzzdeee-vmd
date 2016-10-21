# This class maintains the hypervisor daemon
class vmd::service (
  $ensure = running,
  $enable = true,
) {
  service { 'vmd':
    ensure => $ensure,
    enable => $enable,
  }
}
