# SUSE's openQA tests
#
# Copyright © 2018 SUSE LLC
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

# Summary: mdadm test, run script creating RAID 0, 1, 5, re-assembling and replacing faulty drive
# Maintainer: Jozef Pupava <jpupava@suse.com>

use base 'consoletest';
use testapi;
use strict;

sub run {
    select_console 'root-console';

    assert_script_run 'wget ' . data_url('qam/mdadm.sh');
    assert_script_run 'bash mdadm.sh |& tee mdadm.log; if [ ${PIPESTATUS[0]} -ne 0 ]; then false; fi';
    upload_logs 'mdadm.log';
}

sub post_fail_hook {
    upload_logs 'mdadm.log';
}

1;
