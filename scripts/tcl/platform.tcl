
proc generate_platform {prj_dir xsa_pkg} {
    setws ${prj_dir}
    platform create -name "platform" -hw ${xsa_pkg}  -proc psu_cortexa53_0 -os standalone 
    domain create -name domain_bm_a53 -os standalone -proc psu_cortexa53_0 -arch 64-bit
    platform generate -domains domain_bm_a53
}

set project_dir [lindex $argv 0]
set xsa_package [lindex $argv 1]
generate_platform $project_dir $xsa_package