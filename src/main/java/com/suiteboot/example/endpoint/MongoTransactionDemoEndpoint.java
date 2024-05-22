package com.suiteboot.example.endpoint;

import com.suiteopen.boot.common.utils.JsonUtils;
import com.suiteopen.boot.custom.core.transaction.RFilters;
import com.suiteopen.boot.custom.core.transaction.TxRecordClient;
import com.suiteopen.boot.custom.core.transaction.WithTransaction;
import com.suiteopen.boot.custom.domain.CustomRecord;
import io.opentelemetry.instrumentation.annotations.WithSpan;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

@Slf4j
@RequestMapping
@RestController
public class MongoTransactionDemoEndpoint {
    private final TxRecordClient txRecordClient;
    public MongoTransactionDemoEndpoint(TxRecordClient txRecordClient) {
        this.txRecordClient = txRecordClient;
    }

    @WithSpan
    @GetMapping("/tx")
    @WithTransaction(observable = true, concurrency = 5, enableLock = true)
    public Object findInTransaction() {

        CustomRecord customRecord = txRecordClient.first("sales_order", RFilters.create())
                .orElse(null);

        log.atInfo().setMessage(JsonUtils.toJson(customRecord))
                .addKeyValue("id",1)
                .log();

        return new HashMap<>();
    }
}
