# RFC for count on AzureRM.Storage_Data_Disk

   storage_data_disk {
        count = 2
        name                    = "MetaDisk-${count.index}"
        disk_size_gb  = "1023"
        create_option = "empty"
        managed_disk_type = var.ddve_disk_type
        lun                     = count.index    
    }


####


  {
    "ddve_meta_disks":[1000,1000,1000,1000,1000,1000,1000,1000,1000,1000],
    "ddve_type":"96 TB DDVE",
    "ddve_version": "7.13.0020.MSDN"    
  },
    {
    "ddve_meta_disks":[2000,2000,2000,2000,2000,2000,2000,2000,2000,2000,2000,2000,2000],
    "ddve_type":"256 TB DDVE",
    "ddve_version": "7.13.0020.MSDN"
    },
  {
    "ddve_meta_disks":[1000,1000,1000,1000],
    "ddve_type":"32 TB DDVE",
    "ddve_version": "7.13.0020.MSDN"
  }  


  