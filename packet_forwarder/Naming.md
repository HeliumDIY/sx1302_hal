# File Naming Conventions

The LoRa Alliance Regional spec defines a set of possible frequencies.  The set of configs here
define an actual implemented set of listening frequencies.  Therefore there can be many
different configurations which conform to a Region frequency plan.

All files end with one to three characters which enumerate the configurations.  The Naming convention
is intended to allow future flexibility as new Region plan implementation variants are added.  New
variants can be added for many reasons, including regulatory or to minimize interference.

Soft links exist to maintain compatibility with the old naming scheme.  For example:
AS923_1 -> AS923_1A
EU868 -> EU868_A

## Fixed Frequency Plans
US915 and AU915 are the only fixed frequency plans.  These configurations end with _SB1, _SB2, _SB3, etc
indicating the 8-channel sub-bank used within the configuration.  Helium currently uses sub-bank two
for both US915 and AU915.  Sub-banks consist of eight channels.

## Dynamic Frequency Plans
All Dynamic Plans allow any set of frequences between the tx_freq_min and tx_freq_max.
The original set of dynamic plans is appended with _A indicating this is the first implementation.
New varations will be appended with _B, _C, _D etc.

## AS923 Frequency Plans
There are four main variants AS923_1, AS923_2, AS923_3 and AS923_4.  Within these variants there can
be multiple actual implementations.  Therefore we label plans as _1A, _1B, _1C, etc and _2A, _2B, etc.

## Notes
Hotspot integration notes
https://docs.helium.com/mine-hnt/full-hotspots/become-a-maker/docker-integration/

DeWi HPlans - determines lat-lon to region mapping
https://github.com/dewi-alliance/hplans
