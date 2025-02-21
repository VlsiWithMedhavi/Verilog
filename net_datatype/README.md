# **Verilog "net" datatypes**
## 1. wire  
*Hardware quivalent*: Simple connecting wire driven by a single circuit connection.    
  
*Subtypes*:  
**wand**(wire with an AND gate)  
**wor**(wire with an OR gate)   
  
*Typically used when same wire is driven by multiple output circuits.* 
## 2. tri
*Hardware quivalent*: Simple connecting wire driven by a multiple circuit connection.  
  
*Subtypes*:  
**triand**(tri with an AND gate)  
**trior**(tri with an OR gate)  
*Typically used when same wire is driven by multiple output circuits.*  

**tri0**(wire connected to a resistive pull down device). Outputs 0 when undriven.  
**tri1**(wire connected to a resistive pull up device). Outputs 1 when undriven.
## 3. Supply
*Hardware quivalent*: Supply strength  
  
*Subtypes*:  
**supply0**(constant logic 0). Outputs 0 always irrrspective of its driving state. Emulates wire connected to ground.  
**supply1**(constant logic 1). Outputs 1 always irrrspective of its driving state. Emulates wire connected to power supply.

       
