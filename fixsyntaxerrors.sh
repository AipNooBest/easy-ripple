#!/bin/bash
cd fixedfiles
mv changelogHandler.py ../../lets/handlers/ -f
mv charts.py ../../lets/objects/ -f
mv generalHelper.py ../../lets/helpers/ -f
mv lastFMHandler.py ../../lets/handlers/ -f
mv rateHandler.py ../../lets/handlers/ -f
cd ..
echo Готово!


