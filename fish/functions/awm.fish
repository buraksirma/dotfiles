#!/usr/bin/env fish

function awm -d "Switches aws profile and opens sso login if necessary"
    function sso_login_check -d "Checks login status" -a profile
        if not aws sts get-caller-identity --query Account --output text &>/dev/null
            aws sso login --profile $profile
        end
    end

    set -Ux AWS_PROFILE (aws configure list-profiles | fzf --ansi --no-preview || return 1)
    sso_login_check $AWS_PROFILE
    set -Ux AWS_REGION (aws configure get region)
end
