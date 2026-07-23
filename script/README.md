## Run max file script and FM compiler

1. update xlsx filename
2. node script/convert-excel-to-max.js
3. cp ~/eclipse-workspace/EHRSFM/medlistfp-ig/script/medlist-profiledefinition.max ~/Shared/VisualStudio\ Projects/ehrsfm-tool/import-scripts/output/
4. cd ~/Shared/VisualStudio Projects/ehrsfm-tool
5. start docker (see README with ehrsfm-tool)
6. (ehrs-tool)@> ./gen-medlist.sh
7. cp ~/Shared/VisualStudio\ Projects/ehrsfm-tool/import-scripts/output/medlist.max ~/eclipse-workspace/EHRSFM/medlistfp-ig/script/
8. (medlistfp)@> node script/max2fhir.js
9. use prompt to repair stereotypes