-- CREATE EVN_average_customer_waiting_time_every_1_hour
CREATE TABLE `customer_service_kpi` (
    `customer_service_KPI_timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, `customer_service_KPI_average_waiting_time_minutes` INT NOT NULL,
    PRIMARY KEY (`customer_service_KPI_timestamp`));

SET GLOBAL event_scheduler = ON;

CREATE EVENT IF NOT EXISTS `EVN_average_customer_waiting_time_every_1_hour`
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    INSERT INTO customer_service_kpi (customer_service_KPI_average_waiting_time_minutes)
    SELECT AVG(waiting_time_minutes)
    FROM customer_service_ticket WHERE ticket_timestamp >= NOW() - INTERVAL 1 HOUR;
END;
