This documents describes the additional steps if you want to use the sequenceiq/packer Docker image
to create images on Azure.

## Install azure cli

To get your **publish setting** which is used as you credentials, you need to install the
azure cli:

```
npm install azure-cli -g

```

Once it finished, you have to login:

```
azure login
```

## Download your publish settings

Instead of clicking around the Azure console hopelessly, the cli can redirect your
browser to the *publish settings download* page:
```
azure account download
```

It will download a file something like: `Pay-As-You-Go-XXXXXXXX-credentials.publishsettings`

## Fix invalid Subscription name

If your filename contains `Pay-As-You-Go`, you have to fix its content.

```
 <Subscription
      ServiceManagementUrl="https://management.core.windows.net"
      Id="xxxxxxxxxxxxxxxxxxxxxxxxx"
      Name="Pay-As-You-Go"
```

Rename the file to `YOURNAME.publishsettings`, and replace **Name** attribute in the **Subscription** 
xml element from Pay-As-You-Go to YOURNAME.

```
 <Subscription
      ServiceManagementUrl="https://management.core.windows.net"
      Id="xxxxxxxxxxxxxxxxxxxxxxxxx"
      Name="YOURNAME"
```

## Sample packer file

Here is a slightly modified version of the original 
[example](https://github.com/MSOpenTech/packer-azure/blob/master/bin/driver_restapi/config_examples/packer-azure_Ubuntu_serv14.json)

```
{
	"variables":
	{
		"sn" : "",
		"psPath" : ""
	},

	"builders":
	[
		{
			"type"				: "azure",
			"publish_settings_path" 	: "{{user `psPath`}}",
			"subscription_name"		: "{{user `sn`}}",
			"storage_account" 		: "XXXXXXXXXXXXXXXXXXXX",
			"storage_account_container" 	: "images",
			"os_type"			: "Linux",
			"os_image_label"		: "Ubuntu Server 14.04 LTS",
			"location"			: "West Europe",
			"instance_size"			: "Large",
			"user_image_label"		: "packer-cloudbreak-{{ isotime \"2006-01-02\" }}"
		}
	],
  "provisioners": [{
    "type": "file",
    "source": "scripts/",
    "destination": "/tmp"
  },
  {
    "type": "shell",
    "script": "./user-data-script.sh",
    "execute_command": "chmod +x {{ .Path }}; {{ .Vars }} sudo -E bash '{{ .Path }}'"
  }]
}
```

Its defining 2 variables:
- **psPath** : publish settings file patch
- **sn** : Subscription Name, this is the string we used inside of the publish settings xml.
```
packer validate -var sn=YOURNAME -var psPath=./YOURNAME.publishsettings packer-azure.json
```

## Storage Account

The storage account is usually a rather crypted looking string.
To get the list of yours:

```
azure storage account list 
```
