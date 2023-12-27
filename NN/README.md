# 1 - Callout

Free plan for countrylayer.com is used, hence no https possible, only http. Subsequently Custom Settings was used for storing url and token along with Remote Site Settings.

Queueable job is schedulet to run each night at 1:00. (System.schedule('NN_CountrylayerSERVSchedulableJob', '0 0 1 ? * * *', new NN_CountrylayerSERVSchedulable());)
To execute it ad-hoc, use anonymous window and fire a code: new NN_CountrylayerSERVSchedulable().execute(null);

Trigger is updating only Country on Lead object. After task refinement it is possible to extend the update to other fields.

Metadata:

# 2 - Validation Rule
Metadata:
https://github.com/ceo-cenytovarov-sk/sf-public/blob/main/NN/force-app/main/default/objects/Lead/validationRules/NN_OwnerChange.validationRule-meta.xml

# 3 - Flow
Metadata:
https://github.com/ceo-cenytovarov-sk/sf-public/blob/main/NN/force-app/main/default/flows/NN_LeadBeforeSaveFlow.flow-meta.xml


# Demo Org:
https://empathetic-otter-41d7tw-dev-ed.trailblaze.lightning.force.com/
User with System Administrator profile:
  Username: ceo@empathetic-otter-41d7tw.com
  Pwd: nn-homework1
User with NN - System Administrator profile (to check the validation rule):
  Username: mwmtrust.reality@nn-homework.comn
  Pwd: nn-homework1  
