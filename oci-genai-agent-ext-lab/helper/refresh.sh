cd oci-starter/output
./destroy.sh --auto-approve
cd ..
rm -Rf output
git pull origin main
./oci_starter.sh -compartment_ocid ocid1.compartment.oc1..aaaaaaaadlidudnjfmdhxp4pzsyezf47eetw2g3jff44e4z7mcne4n563guq -language java -java_framework springboot -deploy compute -db_password LiveLab_12345 
cd output
./build.sh
