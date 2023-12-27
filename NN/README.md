# 1 - Callout

Free plan for countrylayer.com is used, hence no https possible, only http. Subsequently Custom Settings was used for storing url and token along with Remote Site Settings.

Queueable job is schedulet to run each night at 1:00. (System.schedule('NN_CountrylayerSERVSchedulableJob', '0 0 1 ? * * *', new NN_CountrylayerSERVSchedulable());)
To execute it ad-hoc, use anonymous window and fire a code: new NN_CountrylayerSERVSchedulable().execute(null);

Trigger is updating only Country on Lead object. After task refinement it is possible to extend the update to other fields.

Overall code coverage is 93%. 

Metadata:
https://github.com/ceo-cenytovarov-sk/sf-public/tree/main/NN/force-app/main/default/classes

https://github.com/ceo-cenytovarov-sk/sf-public/tree/main/NN/force-app/main/default/triggers

https://github.com/ceo-cenytovarov-sk/sf-public/tree/main/NN/force-app/main/default/remoteSiteSettings

https://github.com/ceo-cenytovarov-sk/sf-public/tree/main/NN/force-app/main/default/objects/NN_Countrylayer2RegionalBlock__c

https://github.com/ceo-cenytovarov-sk/sf-public/tree/main/NN/force-app/main/default/objects/NN_Countrylayer__c

https://github.com/ceo-cenytovarov-sk/sf-public/tree/main/NN/force-app/main/default/objects/NN_RegionalBlock__c

https://github.com/ceo-cenytovarov-sk/sf-public/tree/main/NN/force-app/main/default/objects/NN_Token__c

# 2 - Validation Rule
Metadata:
https://github.com/ceo-cenytovarov-sk/sf-public/blob/main/NN/force-app/main/default/objects/Lead/validationRules/NN_OwnerChange.validationRule-meta.xml

# 3 - Flow
Metadata:
https://github.com/ceo-cenytovarov-sk/sf-public/blob/main/NN/force-app/main/default/flows/NN_LeadBeforeSaveFlow.flow-meta.xml
https://github.com/ceo-cenytovarov-sk/sf-public/blob/main/NN/force-app/main/default/objects/Lead/fields/NN_OwnerSince__c.field-meta.xml

# Demo Org:
https://empathetic-otter-41d7tw-dev-ed.trailblaze.lightning.force.com/
User with System Administrator profile:
  Username: ceo@empathetic-otter-41d7tw.com
  Pwd: nn-homework1
User with NN - System Administrator profile (to check the validation rule):
  Username: mwmtrust.reality@nn-homework.comn
  Pwd: nn-homework1  
