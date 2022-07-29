***************************************************************
 Designer Component for Delphi (3-7) and C++ Builder (3-6)
 Runtime Form Designer Component
 Copyright (C) 2003 Greatis Software
***************************************************************

This component must replace TFormDesigner in the future, but
we have some problems with this component yet.
You can try to use it in your application.

This component uses new techology that allows to get any events
from the edited form directly without hooks or application 
events by Designer property of the form object (IDE editor uses 
the same technology at designtime). In this component we emulate
design-time mode, but some controls have strange problems in
this mode (for instance, drop-down list of protected combo box
on the edited form opens only by double-click, and single-click
is ignored). The new techology gives more stable message 
processing, so if this component works fine in your application,
we recommend to use it instead of TFormDesigner.

More important differences between old and new components:
1) We don't use lists for protected, locked and transparent
controls, we just uses one event for all these cases:
OnComponentAttributes.
2) New component allows to edit non-visual components, se we 
have additional Creation Order dialog.
3) OnBeforeMessage and OnAfterMessage events give you full 
control on the message processing. If you set Processed event
parameter to True the default message processing will be
disabled.

See full component description in DOCS\DESCOMP.RTF.

Please note, that it's not a draft or beta-version, it's a 
full-functional component, that just has small problems.
We solved hundreds of problems when creating this component and 
hope to solve all current problems in the nearest future.

Please, send all feedback about this component to 
b-team@greatis.com