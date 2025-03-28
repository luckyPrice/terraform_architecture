module "application" {
    source = "./module/application"
    vpc_id = module.vpc.vpc_id
    public_subnet_id = module.vpc.public_subnet_id
    application_subnet_id = module.vpc.application_subnet_id
    eice_sg_id = module.vpc.eice_sg_id

    instance_ami = var.instance_ami
}

module "vpc" {
    source = "./module/vpc"
    vpc_cidr = var.vpc_cidr
    subnet_cidr = var.subnet_cidr
}

module "db" {
    source = "./module/db"
    db_name = var.db_name
    username = var.username
    rds_password = var.rds_password

    application_sgid = module.application.application_sg_id

    vpc_id = module.vpc.vpc_id
    db_subnet_id = module.vpc.db_subnet_id
    availability_zone_list = var.availability_zone_list
}