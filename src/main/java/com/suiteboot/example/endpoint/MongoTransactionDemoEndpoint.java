package com.suiteboot.example.endpoint;

import com.suiteopen.boot.common.log.Logs;
import com.suiteopen.boot.custom.core.transaction.RFilters;
import com.suiteopen.boot.custom.core.transaction.TransactionCommand;
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
        TransactionCommand<CustomRecord> command = txRecordClient.firstAsync(
                "sales_order", RFilters.create());
        CustomRecord customRecord = command.get();

        log.atInfo().setMessage("This an test log message.")
                .addKeyValue("id",1)
                .addKeyValue("commandType", command.getCommandType())
                .addKeyValue("customRecord",customRecord)
                .addMarker(Logs.OTEL_BIZ_MARKER)
                .log();

        return new HashMap<>();
    }
}
