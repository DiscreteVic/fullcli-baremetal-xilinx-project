


proc flash_platform {prj_dir app_name} {
    connect

    #Reset system
    targets -set -nocase -filter {name =~ "*PSU*"}
    rst

    #Burn bitstream
    targets -set -nocase -filter {name =~ "*PS TAP*"}
    fpga ${prj_dir}/platform/hw/design_1_wrapper.bit

    #PMU
    targets -set -nocase -filter {name =~ "*PSU*"}  
    mask_write 0xFFCA0038 0x1C0 0x1C0
    targets -set -nocase -filter {name =~ "*MicroBlaze PMU*"}
    dow ${prj_dir}/platform/zynqmp_pmufw/pmufw.elf
    con
    targets -set -nocase -filter {name =~ "*PSU*"}
    mask_write 0xFFCA0038 0x1C0 0x0

    #APU and PSU Init
    targets -set -nocase -filter {name =~ "*APU*"}
    mwr 0xffff0000 0x14000000
    mask_write 0xFD1A0104 0x501 0x0
    psu_init

    #FSBL
    targets -set -nocase -filter {name =~ "*A53 #0*"}
    dow ${prj_dir}/platform/zynqmp_fsbl/fsbl_a53.elf
    con
    after 4000; stop

    #APP
    dow ${prj_dir}/project/build/${app_name}.elf
    con
}


set project_dir [lindex $argv 0]
set app_name [lindex $argv 1]
source ${project_dir}/platform/hw/psu_init.tcl
flash_platform $project_dir $app_name