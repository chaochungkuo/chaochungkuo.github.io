---
title: Positive and negative controls in NGS research
date: 2024-08-06
categories: [Sequencing technologies, controls]
tags: [controls, ngs]  # TAG names should always be lowercase
published: true
---

Next-Generation Sequencing (NGS) is a powerful tool in genomics research, allowing for the high-throughput sequencing of DNA and RNA. To ensure the accuracy and reliability of NGS experiments, researchers use positive and negative controls. Here's a detailed explanation of these controls along with examples:

### Positive Controls

**Positive controls** are samples or conditions where the outcome is known and expected to yield a positive result. These controls help to confirm that the NGS process is working correctly and that the sequencing reagents and protocols are functioning as intended.

#### Examples of Positive Controls:

1. **Known Sequencing Standard:**
   - **Example:** A commercially available reference DNA sample with a well-characterized sequence. When this sample is sequenced, it should produce the expected sequence data. Discrepancies can indicate issues with the sequencing process or data analysis.

2. **Spike-In Controls:**
   - **Example:** Adding a synthetic RNA or DNA sequence (which is not present in the sample) to the library preparation. The presence and correct sequence of this spike-in can confirm that the library preparation, sequencing, and data analysis are all functioning properly.

3. **Known Mutations:**
   - **Example:** Using a sample with known genetic mutations or variants. When sequenced, the expected variants should be detected, verifying that the sequencing and variant calling procedures are accurate.

### Negative Controls

**Negative controls** are samples or conditions expected to yield no result or a negative result. These controls help to identify contamination or non-specific binding, ensuring the specificity and accuracy of the NGS experiment.

#### Examples of Negative Controls:

1. **Blank Control:**
   - **Example:** A sample containing no DNA or RNA (e.g., water or buffer) that goes through the entire library preparation and sequencing process. Any sequences detected in this control indicate contamination or reagent carryover.

2. **Non-Template Control (NTC):**
   - **Example:** A PCR reaction without any template DNA. This control helps to detect contamination in the reagents or cross-contamination during the experiment.

3. **Unrelated DNA/RNA:**
   - **Example:** Using DNA or RNA from an unrelated species or organism that should not match the target sequences. Detection of sequences in this control suggests potential cross-contamination or non-specific amplification.

### Importance of Controls in NGS Research

Controls are crucial for:

1. **Validation of Protocols:**
   - Ensuring that all steps in the NGS workflow, from library preparation to sequencing and data analysis, are functioning correctly.

2. **Detection of Contamination:**
   - Identifying any contamination in samples, reagents, or equipment, which can lead to false results.

3. **Assuring Data Quality:**
   - Providing confidence that the data generated is accurate and reliable, which is essential for downstream analyses and interpretations.

### Summary

In summary, positive and negative controls are integral components of NGS research, ensuring the accuracy, reliability, and validity of the sequencing data. By including these controls in experiments, researchers can identify and troubleshoot potential issues, ultimately leading to more robust and trustworthy genomic insights.
