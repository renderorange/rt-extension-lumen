use lib '.';
use inc::Module::Install;

RTx     'RT-Extension-Lumen';
license 'gpl_2';

requires_rt '6.0.0';
rt_too_new '6.1.0';

WriteAll;
