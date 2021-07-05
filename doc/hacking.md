# Hacking Notes - Sawmill Machine Programming Toolkit
## VM
The Windows license is locked-in as spcecified in the file
[product-keys.md](product-keys.md).

In case you need a clean slate: transfering the product key to another
motherboard is difficult: it involves creating a Microsoft account, which I was
appalled to do. Luckily, VMs are not real hardware. You can set the
"hardwareuuid"(VBox equivalent of motherboard serial) like so.

```sh
vboxmanage modifyvm fxsucc --hardwareuuid <uuid>
```

Note that "piix3" chipset is used.

## Battery Backed SRAM of PLC
The PLC uses battery-backed SRAM. The PLC only initialises a small portion of
the memory when powering up. All the variables are preserved even after power
loss. This also means that, if the used battery is non-rechargeable, the PLC
will start having trouble keeping parameters when the battery flats out. If the
battery a rechargeable one, not running the saw for a long period of time can
lead to loss of saved parameters on the PLC(the PLC will restore from flash if
the data in the SRAM is lost).

Here's a good article about BBSRAM:
https://wiki.neogeodev.org/index.php?title=Battery-backed_RAM

## PLC Factory Reset
If you screw up, you can always restore the state of the PLC to the factory
state using `$$$` online command. Connect your PC to COM1 of the PLC. Power on
the saw. Do the typing.

```sh
# Configure the serial for COM1
stty -F /dev/ttyUSB0 38400 cs8 -parenb -cstopb crtscts
# Send the command
echo '@$$$' | unix2mac > /dev/ttyUSB0
```

The manual of the [AWM version](oem/cfs-100/31-5045-Manual%20Reduc%20Size.pdf)
of the docking saw covers the factory reset feature on the HMI(page 54). this
operation was once exposed in the HMI but removed later for some reason. My
guess is that the users couldn't wait for the PLC to finish the operation and
turned the saw off and on again. And this made the HMI unable to boot up
somehow. Or it's very well possible that the developers determined that the
feature is simply too dangerous.

I haven't done this myself, but I'm confident that they flash the PLCs before
shipping out(it'd be really really stupid not to).

## Links
*Copied from: https://github.com/ashegoulding/CFS-100*

Excuse me for not following the 80 column rule here. For the record, I don't
speak Chinese. Google Translate worked like a charm.

### Misubishi Electric
* GX Works 2 Trial Version
  * https://www.mitsubishifa.co.th/en/Software-Detail.php?id=MTE=&vs=trial
  * https://www.mitsubishifa.co.th/en/Software-Detail.php?id=MTE=&vs=update

* GX Works 2 Manual: http://www.int76.ru/upload/iblock/5c9/5c951f4448672b4f8143a7f284cd2545.pdf
* GX Works 2 Beginner's Manual: https://dl.mitsubishielectric.com/dl/fa/document/manual/plc/sh080787eng/sh080787engr.pdf
* CRACKING THE MITSUBISHI “KEYWORD": http://docshare01.docshare.tips/files/4602/46027935.pdf
* FX1S - Hardware Manual JY992D83901-P (04.15).pdf: http://suport.siriustrading.ro/02.DocArh/01.PLC/02.Compacte/03.MELSEC%20FX0(1)S,FX0(1)N,FX2N(C)/01.Unitati%20de%20baza/FX1S%20-%20Hardware%20Manual%20JY992D83901-P%20(04.15).pdf
* jy992d48301j.pdf: http://dl.mitsubishielectric.com/dl/fa/document/manual/plc_fx/jy992d48301/jy992d48301j.pdf
* jy992d55301h.pdf: https://dl.mitsubishielectric.com/dl/fa/document/manual/plc_fx/jy992d55301/jy992d55301h.pdf
* jy992d66501f.pdf: https://dl.mitsubishielectric.com/dl/fa/document/manual/plc_fx/jy992d66501/jy992d66501f.pdf
* jy992d69901e.pdf: https://dl.mitsubishielectric.com/dl/fa/document/manual/plc_fx/jy992d69901/jy992d69901e.pdf
* sh080787engr.pdf: https://dl.mitsubishielectric.com/dl/fa/document/manual/plc/sh080787eng/sh080787engr.pdf

### CFS-100 (Docking Saw)
* Kuang Yung: https://www.kuangyung.com.tw/cfs-100-cut-off-saw-en
* Titan: https://titanwm.com.au/docking-saw-cfs-100/
* AW Machinery
  * https://www.awmachineryllc.com/downloads/31-5045-Manual%20Reduc%20Size.pdf
  * https://www.awmachineryllc.com/downloads/903-5045_Cutoff_Saw.pdf

### UTSD-105
* OEM download page(iframe source): http://www.utrend.com.tw/syspro_e.htm
* OEM software
  * http://www.utrend.com.tw/UsersManual/UTSD3.0manual_eng.pdf
  * http://www.utrend.com.tw/ut/UTC_Setup+_Eng.zip
  * http://www.utrend.com.tw/ut/UTC_Setup_Eng.zip
  * http://www.utrend.com.tw/UsersManual/UTCPanel_Guide_E.pdf
  * http://www.utrend.com.tw/UsersManual/UTCPanel+_Guide_E.pdf
  * http://www.utrend.com.tw/ut/UTC-Training-course.pps
* Potential retail?: http://www.commerce.com.tw/modules.php?modules=products&action=detail&ID=A0001583&no=63726&category=0&catid=7142#

### GT056
* Product catalogue: https://cht.nahua.com.tw/cermate/gt/gt056/gt056.pdf
* OEM software download page: https://amenss.com/modules/mydownloads/
* PM SCADA V2.1: https://amenss.com/modules/mydownloads/visit.php?cid=20&lid=112
* PM SCADA V1.2: https://amenss.com/modules/mydownloads/visit.php?cid=17&lid=63

* OEM software "PM" series outdated generic manual: http://yourplc.net/download/manual/hmi/amens/pm%20manual_e.pdf
* PLC Connection Guide: https://www.cermate.com/TN504D_V1_SAIA_PCD3_E0.pdf
* Installation Guide: http://www.offpeak-solutions.com/images/PTSeriesInstallationGuide.pdf

* SoC datasheet: http://www.nuvoton.com.ua/docs/mcu2/NUC950ADN_data_sheet_Ver_A4.pdf
