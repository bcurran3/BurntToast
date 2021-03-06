function Remove-BTNotification {
    <#
        .SYNOPSIS
        Removes toast notifications from the Action Center.

        .DESCRIPTION
        The Remove-BTNotification function removes toast notifications from the Action Center.

        If no parameters are specified, all toasts (for the default AppId) will be removed.

        Tags and Groups for Toasts can be found using the Get-BTHistory function.

        .INPUTS
        LOTS

        .OUTPUTS
        NONE

        .EXAMPLE
        Remove-BTNotification

        .EXAMPLE
        Remove-BTNotification -Tag 'UniqueIdentifier'

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Remove-BTNotification.md
    #>

    param (
        # Specifies the AppId of the 'application' or process that spawned the toast notification.
        [string] $AppId = $Script:Config.AppId,

        # Specifies the tag, which identifies a given toast notification.
        [string] $Tag,

        # Specifies the group, which helps to identify a given toast notification.
        [string] $Group
    )

    if (!(Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\$AppId")) {
        Write-Warning -Message "The AppId $AppId is not present in the registry, please run New-BTAppId to avoid inconsistent Toast behaviour."
    }

    if ($Tag -and $Group) {
        [Windows.UI.Notifications.ToastNotificationManager]::History.Remove($Tag, $Group, $AppId)
    } elseif ($Tag) {
        [Windows.UI.Notifications.ToastNotificationManager]::History.Remove($Tag, $AppId)
    } elseif ($Group) {
        [Windows.UI.Notifications.ToastNotificationManager]::History.RemoveGroup($Group, $AppId)
    } else {
        [Windows.UI.Notifications.ToastNotificationManager]::History.Clear($AppId)
    }
}
