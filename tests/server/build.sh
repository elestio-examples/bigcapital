#!/usr/bin/env bash
mv ./packages/server/Dockerfile ./
sed -i "s~return this.salesTaxLiabiltiyPdf.pdf(tenantId, query):~return this.salesTaxLiabiltiyPdf.pdf(tenantId, query);~g" ./packages/server/src/services/FinancialStatements/SalesTaxLiabilitySummary/SalesTaxLiabilitySummaryApplication.ts
docker buildx build . --no-cache --output type=docker,name=elestio4test/bigcapital-server:latest | docker load