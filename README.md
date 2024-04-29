# STM32F2 ADC timer driven DMA

The provided `ecos_stm3220g_eval_plf_adc1` executes on the
STM3220G-EVAL hardware platform using DMA driven ADC, where the DMA is
triggered by a configured timer (TRGO).

Due to the interconnected nature of the H/W controller configuration
more than one model needs to be updated to correctly simulate the
required functionality.

This fork **will** eventually provide updated models as required to
successully execute the test. The initial commit is against an
unmodified Renode environment to exhibit the missing features.

**NOTE**: The, pending, locally "fixed" models have already
successfully run 1000s of eCos testfarm cases under Renode 1.14.0 and
1.15.0 as well as on the real H/W platform. The specific test
application `ecos_stm3220g_eval_plf_adc1` is provided as an ELF image
due to the large number of source files involved and the normal eCos
config+build world using "custom" tools that would just add workload
onto providing a failing example for Renode.

Since the automated test world we use internally does not make use of
the "robot" mechanism, the "test.robot" will be updated as needed as
more of the application execution succeeds using this issue framework.

The following table provides a basic overview of the changes required
to support timer driver DMA based ADC sampling as exercised by the
test ELF. The "Pending" state just indicates that the relevant
changesets have not yet been applied to this repo.

| Issue            | Description                                                                                            | Fix
|:-----------------|:-------------------------------------------------------------------------------------------------------|:-------
| STM32F207        | Hierarchy of ".repl" files to allow STM32F2[01][57] configurations (controllers, flash size, etc.)     | Committed
| STM3220G-EVAL    | Initial (limited) STM32x0G-EVAL platform support (enough to allow test execution)                      | Committed
| STM32_ADC.cs     | Renode exception: Analog.STM32_ADC.OnConversionFinished "Fatal error: Attempted to divide by zero."    | Committed
| STM32_ADC.cs     | Allow 8- and 16-bit reads of the DataRegister (as per RM0033 Rev9 10.13)                               | Committed
| STM32_ADC.cs     | Fix sequence index when ADC_CR2:ADON off and on transitions to avoid DMA transfer data offset mismatch | Committed
| STM32_ADC.cs     | Add support for ADC EXTEN/EXTSEL conversion trigger                                                    | Committed
| STM32DMA.cs      | Fix TX and RX transfer and maintain DMA pending request state                                          | Committed
| STM32DMA.cs      | Fix DMA_SxNDTR access                                                                                  | Committed
| STM32DMA.cs      | Fix transferredSize reset on DMA stream disable                                                        | Committed
| STM32DMA.cs      | Fix DoPeripheralTransfer() to only increment memory when configured for such                           | Committed
| STM32DMA.cs      | Maintain FIFOControl to allow software access                                                          | Committed
| STM32_Timer.cs   | Add TRGO support                                                                                       | Committed
