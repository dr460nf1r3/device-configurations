{ lib, pkgs, ... }:
{
  # These need to be configured individually
  dconf.settings = {
    "org/gnome/shell/extensions/gsconnect" = {
      devices = [ "c9b46110e36de16a" "a4f40eab-47db-47b6-9fda-a4c71d9f2893" ];
      enabled = true;
      id = "a4f40bf4-47db-47b6-9fda-a4c71d9f2893";
      name = "Slim Nixed";
    };
    "org/gnome/shell/extensions/gsconnect/device/a4f40eab-47db-47b6-9fda-a4c71d9f2893" = {
      certificate-pem = "-----BEGIN CERTIFICATE-----\nMIIFpTCCA42gAwIBAgIUA3Xx1N4L8NkLGIfcg0pVf1ZhbHEwDQYJKoZIhvcNAQEL\nBQAwYjEdMBsGA1UECgwUYW5keWhvbG1lcy5naXRodWIuaW8xEjAQBgNVBAsMCUdT\nQ29ubmVjdDEtMCsGA1UEAwwkYTRmNDBiZjQtNDdkYi00N2I2LTlmZGEtYTRjNzFk\nOWYyODkzMB4XDTIzMDMxMTA5MzkyOVoXDTMzMDMwODA5MzkyOVowYjEdMBsGA1UE\nCgwUYW5keWhvbG1lcy5naXRodWIuaW8xEjAQBgNVBAsMCUdTQ29ubmVjdDEtMCsG\nA1UEAwwkYTRmNDBiZjQtNDdkYi00N2I2LTlmZGEtYTRjNzFkOWYyODkzMIICIjAN\nBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAyLOcBq1GRnmiEVZQnz8yZmEmxEav\nPIC/qazqgqU/Oxb85qZzS7/e3CZvVuva++UsMTWZnPdvPx3Md8FGL+jubZw1A13k\niiQ4P2VJ7leRufvpVEaoFL6wOE6tWn7o8m8feniLyN9vlJAJ0fblELAqwvhR3cFj\nY4s/Xi+hOx/iSBbxMI2EaM2BSFTmULSz2SKwlwMAtbgi8Rzk7QvEUIds/HGgBAnJ\nEy1ukX2wiyqbu53PygwWQFUuxH6ErrfHCB7riFyj8ln4Mxvsryhv2USYqZd8n90o\njxEgF7ZinxqS66G+vwg3QYyC0M7QhA+0eMm8cw+R7F6lvJWqZ6jxNxvgaroKPsd7\n/6Yoyt51ygVXpuzsMBt7Qv7V5+sckfpdVL1aj5rvKuc/78lh4kjjsa5JTVnjhUOI\nhQ3nQHAC3c47BzIYBi7uDymwbGbKN870CkcLl1BHAhWVJSS5aGlpE6MYp/pE0WQh\nl78t2gSM1Je6W4hUYkTK+bDqi9Fxsou8SS12irs8MQDSC0/KiTuXeYzQUu5JQAqk\nRCklfwpv85ya5j4h0VEIY0PIhQ4BogZ7W2YxRyP8s7kn75HrlmNgx9JxoGiv6usT\nid1v8nkwGrf97JWa6FImrWj2CFewKSH0wHiZhNhIt2YmF75BuATfIsiInD9QxoeG\nlcrvz+0KUY0g+FsCAwEAAaNTMFEwHQYDVR0OBBYEFGrJF26aKuaC+flCLYLBi3Jx\n2H4jMB8GA1UdIwQYMBaAFGrJF26aKuaC+flCLYLBi3Jx2H4jMA8GA1UdEwEB/wQF\nMAMBAf8wDQYJKoZIhvcNAQELBQADggIBAJFK/18sKLzl0Iu7GfAVnzJiRs4k0x35\nobyXWVSV3jCiRw3/PznWkRxDvToGXSEucNlXdSmZFjSlMgCbAKucuWr6QqE/EM57\nQuzkQrwa6KRrQYazLkrziCWopR3WldrJqgdySY0yL3NSE8jg5u38EGclDkp0Vr9x\nqUUlRaeir+2D5JPUBL2i51KTuQ3VEdHEOjUB/4QLo1lFZ181CqKK65P42O+ZDF/U\nLftLGqDhllAp/lMcVWUTN3JijqvceX5cmY1tIZ56LUKZjFiQI90dZsbuPrAzrewy\nIQYK4T4/yeIhb0Ysbs4qDqcTnyUand4WKnQZukmjpS0Hey5Vl255YoYaTTx5ckpZ\nSRjaLrQiAqGQLH3HNUQIHKQE1i+m7E39R6b1hmRg1zeuC26JCF/iqa6R7QxDAdNc\nLMlXZDwLizhgAui5bmhegPsTxM+iguWIr10cGBIEmAyFEG++1AvQe1MNj/trUQun\nzzsL95A0BhcKW9B54uwLX4HU2PLOW8ANwNJzjOXAcLYWsRhkHTRkh2DRyim7axiV\nK+xxPa0d/hmGj4LEEu31Y5e/FnD6etBQhcj4pxnWXhv3B+Enr1Q7otaljdCDIEuT\nuC2W7YCIZej+zsnev0IlVp6d2yigQtq6PwZTxZy5LizpkvW3tHxJ7iKOdWJ1iC6r\n6elAnwseDDcP\n-----END CERTIFICATE-----\n";
      incoming-capabilities = [ "kdeconnect.battery" "kdeconnect.battery.request" "kdeconnect.clipboard" "kdeconnect.clipboard.connect" "kdeconnect.connectivity_report" "kdeconnect.contacts.response_uids_timestamps" "kdeconnect.contacts.response_vcards" "kdeconnect.findmyphone.request" "kdeconnect.mousepad.echo" "kdeconnect.mousepad.keyboardstate" "kdeconnect.mousepad.request" "kdeconnect.mpris" "kdeconnect.mpris.request" "kdeconnect.notification" "kdeconnect.notification.request" "kdeconnect.photo" "kdeconnect.photo.request" "kdeconnect.ping" "kdeconnect.presenter" "kdeconnect.runcommand" "kdeconnect.runcommand.request" "kdeconnect.sftp" "kdeconnect.share.request" "kdeconnect.sms.messages" "kdeconnect.systemvolume.request" "kdeconnect.telephony" ];
      name = "TV NixOS";
      outgoing-capabilities = [ "kdeconnect.battery" "kdeconnect.battery.request" "kdeconnect.clipboard" "kdeconnect.clipboard.connect" "kdeconnect.connectivity_report.request" "kdeconnect.contacts.request_all_uids_timestamps" "kdeconnect.contacts.request_vcards_by_uid" "kdeconnect.findmyphone.request" "kdeconnect.mousepad.echo" "kdeconnect.mousepad.keyboardstate" "kdeconnect.mousepad.request" "kdeconnect.mpris" "kdeconnect.mpris.request" "kdeconnect.notification" "kdeconnect.notification.action" "kdeconnect.notification.reply" "kdeconnect.notification.request" "kdeconnect.photo" "kdeconnect.photo.request" "kdeconnect.ping" "kdeconnect.runcommand" "kdeconnect.runcommand.request" "kdeconnect.sftp.request" "kdeconnect.share.request" "kdeconnect.sms.request" "kdeconnect.sms.request_conversation" "kdeconnect.sms.request_conversations" "kdeconnect.systemvolume" "kdeconnect.telephony.request" "kdeconnect.telephony.request_mute" ];
      paired = true;
      supported-plugins = [ "battery" "clipboard" "findmyphone" "mousepad" "mpris" "notification" "photo" "ping" "runcommand" "share" ];
      type = "laptop";
    };
    "org/gnome/shell/extensions/gsconnect/device/a4f40eab-47db-47b6-9fda-a4c71d9f2893/plugin/battery" = {
      custom-battery-notification = true;
      custom-battery-notification-value = mkUint32 85;
      full-battery-notification = true;
    };
    "org/gnome/shell/extensions/gsconnect/device/a4f40eab-47db-47b6-9fda-a4c71d9f2893/plugin/clipboard" = {
      receive-content = true;
      send-content = true;
    };
    "org/gnome/shell/extensions/gsconnect/device/a4f40eab-47db-47b6-9fda-a4c71d9f2893/plugin/notification" = {
      applications = ''
        {"Power":{"iconName":"org.gnome.Settings-power-symbolic","enabled":true},"Lutris":{"iconName":"lutris","enabled":true},"Software":{"iconName":"org.gnome.Software","enabled":true},"Clocks":{"iconName":"org.gnome.clocks","enabled":true},"Color":{"iconName":"org.gnome.Settings-color-symbolic","enabled":true},"Archive Manager":{"iconName":"org.gnome.FileRoller","enabled":true},"PulseEffects":{"iconName":"pulseeffects","enabled":true},"Printers":{"iconName":"org.gnome.Settings-printers-symbolic","enabled":true},"Telegram Desktop":{"iconName":"telegram","enabled":true},"Files":{"iconName":"org.gnome.Nautilus","enabled":true},"Disk Usage Analyzer":{"iconName":"org.gnome.baobab","enabled":true},"Disks":{"iconName":"org.gnome.DiskUtility","enabled":true},"Evolution Alarm Notify":{"iconName":"appointment-soon","enabled":true},"Date & Time":{"iconName":"org.gnome.Settings-time-symbolic","enabled":true}}
      '';
    };
    "org/gnome/shell/extensions/gsconnect/device/c9b46110e36de16a" = {
      certificate-pem = "-----BEGIN CERTIFICATE-----\nMIIC9zCCAd+gAwIBAgIBATANBgkqhkiG9w0BAQsFADA/MRkwFwYDVQQDDBBjOWI0\nNjExMGUzNmRlMTZhMRQwEgYDVQQLDAtLREUgQ29ubmVjdDEMMAoGA1UECgwDS0RF\nMB4XDTIxMTIzMTIzMDAwMFoXDTMxMTIzMTIzMDAwMFowPzEZMBcGA1UEAwwQYzli\nNDYxMTBlMzZkZTE2YTEUMBIGA1UECwwLS0RFIENvbm5lY3QxDDAKBgNVBAoMA0tE\nRTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMnPph3GhrOXIBrSry6i\nt3I7v9Jy51Cq3izAxh3VNaUCNjkDCCK02hYkKkbMlkixzEIWDGQhvj3nEGp/MWE5\no5A7eE+6n70dKwTa23pJpNy2Vw5B+Kzv6WEslt4XsPhavlC/hvEQRsGPFuW1H02m\nLshuwGT42wbtDVYoSjlETpOTmTHnhEVblXhUoScvYqBocPEVIG55lYXB6ghyyJMX\n/inI4cYdx2K+mirdOqNNNXUOHDkxX8SqBor8czgKGs6rETRC/WP/mUeY3Co+SwlS\nnTkq0VnB8G27VMOlyDd5vXePKxUS7XczaAsNv4D3G8d2S/Z+pDQAEXZF/3qqophT\nPFECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEABX3p3gFU1uWa/oxBveAnBdxZAdTR\n/Z3EqJTKM8NQBgGgEZ4HPPPZF6le0/yqoaSU8Tdo8Q8atNrtKK7o9RWsOl3aG4MY\nIXTOorKqw6EaBZ4++GPTPwf8wgkwjmfgGvVKzYEaDxMsjvYgKhD3DKTmX2iHFuq8\njNZ+Twnv5clHFI7/4sqPmkEBSsS+sGAwgBwTVl4nTk+Rl7qwz485dmZ1tZQxqZaW\nLzKFpr2rDkBtSRyEr9uzyH/UkWaL2LeFkMqkZEgAtRURcorh0CTnO8mGpHFzyfqL\nZSgjp6Mw7RMXlvZAcoME6cdQPURJZhF99Xqz7wvzmC+mx6NnO+juq71IZg==\n-----END CERTIFICATE-----\n";
      incoming-capabilities = [ "kdeconnect.battery" "kdeconnect.battery.request" "kdeconnect.bigscreen.stt" "kdeconnect.clipboard" "kdeconnect.clipboard.connect" "kdeconnect.connectivity_report.request" "kdeconnect.contacts.request_all_uids_timestamps" "kdeconnect.contacts.request_vcards_by_uid" "kdeconnect.findmyphone.request" "kdeconnect.mousepad.keyboardstate" "kdeconnect.mousepad.request" "kdeconnect.mpris" "kdeconnect.mpris.request" "kdeconnect.notification" "kdeconnect.notification.action" "kdeconnect.notification.reply" "kdeconnect.notification.request" "kdeconnect.photo.request" "kdeconnect.ping" "kdeconnect.runcommand" "kdeconnect.sftp.request" "kdeconnect.share.request" "kdeconnect.share.request.update" "kdeconnect.sms.request" "kdeconnect.sms.request_attachment" "kdeconnect.sms.request_conversation" "kdeconnect.sms.request_conversations" "kdeconnect.systemvolume" "kdeconnect.telephony.request" "kdeconnect.telephony.request_mute" ];
      name = "Pixel 6";
      outgoing-capabilities = [ "kdeconnect.battery" "kdeconnect.battery.request" "kdeconnect.bigscreen.stt" "kdeconnect.clipboard" "kdeconnect.clipboard.connect" "kdeconnect.connectivity_report" "kdeconnect.contacts.response_uids_timestamps" "kdeconnect.contacts.response_vcards" "kdeconnect.findmyphone.request" "kdeconnect.mousepad.echo" "kdeconnect.mousepad.keyboardstate" "kdeconnect.mousepad.request" "kdeconnect.mpris" "kdeconnect.mpris.request" "kdeconnect.notification" "kdeconnect.notification.request" "kdeconnect.photo" "kdeconnect.ping" "kdeconnect.presenter" "kdeconnect.runcommand.request" "kdeconnect.sftp" "kdeconnect.share.request" "kdeconnect.sms.attachment_file" "kdeconnect.sms.messages" "kdeconnect.systemvolume.request" "kdeconnect.telephony" ];
      paired = true;
      supported-plugins = [ "battery" "clipboard" "connectivity_report" "contacts" "findmyphone" "mousepad" "mpris" "notification" "photo" "ping" "presenter" "runcommand" "sftp" "share" "sms" "systemvolume" "telephony" ];
      type = "phone";
    };
    "org/gnome/shell/extensions/gsconnect/device/c9b46110e36de16a/plugin/battery" = {
      custom-battery-notification = true;
      custom-battery-notification-value = mkUint32 85;
      full-battery-notification = true;
    };
    "org/gnome/shell/extensions/gsconnect/device/c9b46110e36de16a/plugin/clipboard" = {
      receive-content = true;
      send-content = true;
    };
    "org/gnome/shell/extensions/gsconnect/device/c9b46110e36de16a/plugin/notification" = {
      applications = ''
        {"Power":{"iconName":"org.gnome.Settings-power-symbolic","enabled":true},"Lutris":{"iconName":"lutris","enabled":true},"Software":{"iconName":"org.gnome.Software","enabled":true},"Clocks":{"iconName":"org.gnome.clocks","enabled":true},"Color":{"iconName":"org.gnome.Settings-color-symbolic","enabled":true},"Archive Manager":{"iconName":"org.gnome.FileRoller","enabled":true},"PulseEffects":{"iconName":"pulseeffects","enabled":true},"Printers":{"iconName":"org.gnome.Settings-printers-symbolic","enabled":true},"Telegram Desktop":{"iconName":"telegram","enabled":true},"Files":{"iconName":"org.gnome.Nautilus","enabled":true},"Disk Usage Analyzer":{"iconName":"org.gnome.baobab","enabled":true},"Disks":{"iconName":"org.gnome.DiskUtility","enabled":true},"Evolution Alarm Notify":{"iconName":"appointment-soon","enabled":true},"Date & Time":{"iconName":"org.gnome.Settings-time-symbolic","enabled":true}}
      '';
    };
  }
}
