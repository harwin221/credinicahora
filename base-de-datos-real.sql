-- CrediNica - Base de Datos Real
-- Exportado desde FreeHostia y optimizado para Amazon RDS
-- Fecha: 01-12-2025
-- Compatible con MySQL 8.0+

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `asalariado_info`
-- --------------------------------------------------------

CREATE TABLE `asalariado_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` varchar(255) NOT NULL,
  `companyName` varchar(255) DEFAULT NULL,
  `jobAntiquity` varchar(255) DEFAULT NULL,
  `companyAddress` text,
  `companyPhone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_asalariado_client` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `audit_logs`
-- --------------------------------------------------------

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userId` varchar(255) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `action` varchar(100) NOT NULL,
  `details` text,
  `entityId` varchar(255) DEFAULT NULL,
  `entityType` varchar(50) DEFAULT NULL,
  `changes` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_audit_user` (`userId`),
  KEY `idx_audit_action` (`action`),
  KEY `idx_audit_entity` (`entityId`,`entityType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `sucursales`
-- --------------------------------------------------------

CREATE TABLE `sucursales` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `managerId` varchar(255) DEFAULT NULL,
  `managerName` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `clients`
-- --------------------------------------------------------

CREATE TABLE `clients` (
  `id` varchar(255) NOT NULL,
  `clientNumber` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `cedula` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `sex` varchar(20) DEFAULT NULL,
  `civilStatus` varchar(50) DEFAULT NULL,
  `employmentType` varchar(50) DEFAULT NULL,
  `sucursal_id` varchar(255) DEFAULT NULL,
  `sucursal_name` varchar(255) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `municipality` varchar(100) DEFAULT NULL,
  `neighborhood` varchar(255) DEFAULT NULL,
  `address` text,
  `tags` json DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clientNumber` (`clientNumber`),
  UNIQUE KEY `cedula` (`cedula`),
  KEY `idx_client_name` (`name`),
  KEY `idx_client_sucursal_id` (`sucursal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `closures`
-- --------------------------------------------------------

CREATE TABLE `closures` (
  `id` varchar(255) NOT NULL,
  `userId` varchar(255) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `sucursalId` varchar(255) NOT NULL,
  `closureDate` datetime NOT NULL,
  `systemBalance` decimal(15,2) NOT NULL,
  `physicalBalance` decimal(15,2) NOT NULL,
  `difference` decimal(15,2) NOT NULL,
  `notes` text,
  `denominationsNIO` json DEFAULT NULL,
  `denominationsUSD` json DEFAULT NULL,
  `exchangeRate` decimal(10,4) DEFAULT NULL,
  `clientDeposits` decimal(15,2) DEFAULT NULL,
  `manualTransfers` decimal(15,2) DEFAULT NULL,
  `closedByUserId` varchar(255) NOT NULL,
  `closedByUserName` varchar(255) NOT NULL,
  `reviewedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_closure_user` (`userId`),
  KEY `idx_closure_sucursal` (`sucursalId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `comerciante_info`
-- --------------------------------------------------------

CREATE TABLE `comerciante_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` varchar(255) NOT NULL,
  `businessAntiquity` varchar(255) DEFAULT NULL,
  `businessAddress` text,
  `economicActivity` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comerciante_client` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `counters`
-- --------------------------------------------------------

CREATE TABLE `counters` (
  `id` varchar(50) NOT NULL,
  `clientNumber` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `creditNumber` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `reciboNumber` int(10) UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `credits`
-- --------------------------------------------------------

CREATE TABLE `credits` (
  `id` varchar(255) NOT NULL,
  `creditNumber` varchar(50) NOT NULL,
  `clientId` varchar(255) NOT NULL,
  `clientName` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `applicationDate` datetime NOT NULL,
  `approvalDate` datetime DEFAULT NULL,
  `approvedBy` varchar(255) DEFAULT NULL,
  `rejectionReason` text,
  `rejectedBy` varchar(255) DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `principalAmount` decimal(15,2) NOT NULL,
  `netDisbursementAmount` decimal(15,2) DEFAULT NULL,
  `disbursedAmount` decimal(15,2) DEFAULT NULL,
  `interestRate` decimal(5,2) NOT NULL,
  `termMonths` decimal(5,1) NOT NULL,
  `paymentFrequency` varchar(50) NOT NULL,
  `currencyType` varchar(50) NOT NULL,
  `totalAmount` decimal(15,2) NOT NULL,
  `totalInterest` decimal(15,2) NOT NULL,
  `totalInstallmentAmount` decimal(15,2) NOT NULL,
  `firstPaymentDate` datetime NOT NULL,
  `deliveryDate` datetime DEFAULT NULL,
  `dueDate` datetime DEFAULT NULL,
  `disbursedBy` varchar(255) DEFAULT NULL,
  `collectionsManager` varchar(255) DEFAULT NULL,
  `supervisor` varchar(255) DEFAULT NULL,
  `createdBy` varchar(255) DEFAULT NULL,
  `lastModifiedBy` varchar(255) DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL,
  `branchName` varchar(255) DEFAULT NULL,
  `productType` varchar(100) DEFAULT NULL,
  `subProduct` varchar(100) DEFAULT NULL,
  `productDestination` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `creditNumber` (`creditNumber`),
  KEY `idx_credit_status` (`status`),
  KEY `idx_credit_manager` (`collectionsManager`),
  KEY `idx_credit_branch` (`branch`),
  KEY `fk_credit_client` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `guarantees`
-- --------------------------------------------------------

CREATE TABLE `guarantees` (
  `id` varchar(255) NOT NULL,
  `creditId` varchar(255) NOT NULL,
  `article` varchar(255) NOT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `color` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `series` varchar(100) DEFAULT NULL,
  `estimatedValue` decimal(15,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_guarantee_credit` (`creditId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `guarantors`
-- --------------------------------------------------------

CREATE TABLE `guarantors` (
  `id` varchar(255) NOT NULL,
  `creditId` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `cedula` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `relationship` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_guarantor_credit` (`creditId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `holidays`
-- --------------------------------------------------------

CREATE TABLE `holidays` (
  `id` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `interactions`
-- --------------------------------------------------------

CREATE TABLE `interactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` varchar(255) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `notes` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_interaction_clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `payments_registered`
-- --------------------------------------------------------

CREATE TABLE `payments_registered` (
  `id` varchar(255) NOT NULL,
  `creditId` varchar(255) NOT NULL,
  `paymentDate` datetime NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `managedBy` varchar(255) NOT NULL,
  `transactionNumber` varchar(100) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'VALIDO',
  `voidReason` text,
  `voidRequestedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_payment_creditId` (`creditId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `payment_plan`
-- --------------------------------------------------------

CREATE TABLE `payment_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creditId` varchar(255) NOT NULL,
  `paymentNumber` int(11) NOT NULL,
  `paymentDate` datetime NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `principal` decimal(15,2) NOT NULL,
  `interest` decimal(15,2) NOT NULL,
  `balance` decimal(15,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_plan_creditId` (`creditId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `personal_references`
-- --------------------------------------------------------

CREATE TABLE `personal_references` (
  `id` varchar(255) NOT NULL,
  `clientId` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `relationship` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reference_client` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `system_settings`
-- --------------------------------------------------------

CREATE TABLE `system_settings` (
  `setting_key` varchar(50) NOT NULL,
  `setting_value` json NOT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Estructura de tabla para la tabla `users`
-- --------------------------------------------------------

CREATE TABLE `users` (
  `id` varchar(255) NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `hashed_password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` varchar(50) NOT NULL,
  `sucursal_id` varchar(255) DEFAULT NULL,
  `sucursal_name` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `mustChangePassword` tinyint(1) NOT NULL DEFAULT '0',
  `supervisor_id` varchar(255) DEFAULT NULL,
  `supervisor_name` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_user_role` (`role`),
  KEY `idx_user_sucursal_id` (`sucursal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- DATOS INICIALES
-- --------------------------------------------------------

-- Volcado de datos para la tabla `sucursales`
INSERT INTO `sucursales` (`id`, `name`, `managerId`, `managerName`, `createdAt`, `updatedAt`) VALUES
('suc_1761721008127', 'SUCURSAL PRINCIPAL', 'user_admin_01', 'ADMINISTRADOR DEL SISTEMA', '2025-10-29 06:56:48', '2025-10-29 06:57:44'),
('suc_1762140953432', 'SUCURSAL JINOTEPE', 'user_1762140989702', 'CRISTHIAN BOZA', '2025-11-03 03:35:53', '2025-11-03 03:44:41');

-- Volcado de datos para la tabla `system_settings`
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES
('access_control', '{"isSystemOpen": true, "branchSettings": {"suc_1761721008127": true}}', '2025-11-24 05:01:49');

-- Volcado de datos para la tabla `users`
INSERT INTO `users` (`id`, `fullName`, `email`, `hashed_password`, `phone`, `role`, `sucursal_id`, `sucursal_name`, `active`, `mustChangePassword`, `supervisor_id`, `supervisor_name`, `createdAt`, `updatedAt`) VALUES
('user_1761350279190', 'SUPERVISOR DE PRUEBA', 'supervisor.prueba@credinica.com', '$2a$10$8APQk22ZuPbzNACtS83puOPoqh1ULI26kaLofh1Y68/9GRNB8sqje', '8757-9093', 'SUPERVISOR', 'suc_1761721008127', 'SUCURSAL PRINCIPAL', 1, 0, NULL, NULL, '2025-10-24 23:57:58', '2025-11-02 18:23:48'),
('user_1761350328416', 'GESTOR PRUEBA', 'gestor.prueba@credinica.com', '$2a$10$3RK/9slcgP2SbhpjMQ4us.wJvcA8au.hsToOAByYv6Cq3GMCKOvTa', '8888-8888', 'GESTOR', 'suc_1761721008127', 'SUCURSAL PRINCIPAL', 1, 0, 'user_1761350279190', 'SUPERVISOR DE PRUEBA', '2025-10-24 23:58:47', '2025-11-02 18:23:48'),
('user_1761350361139', 'OPERATIVO DE PRUEBA', 'operativo.prueba@credinica.com', '$2a$10$oYaad3AvrQv8zq4J2yCCf.vs3.sTwc5oo0StquAuuCd.TLUk1kNXS', NULL, 'OPERATIVO', 'suc_1761721008127', 'SUCURSAL PRINCIPAL', 1, 0, NULL, NULL, '2025-10-24 23:59:20', '2025-11-02 18:23:48'),
('user_1761350379417', 'NORVIN RAY0', 'gerente.prueba@credinica.com', '$2a$10$ZPlPAgL3n0Ckl.VRd7he4u0se.f1rUrEEX.0OC71ER1..YeWGxn8y', NULL, 'GERENTE', 'suc_1761721008127', 'SUCURSAL PRINCIPAL', 1, 0, NULL, NULL, '2025-10-24 23:59:38', '2025-11-02 18:25:57'),
('user_1761350400282', 'LUIS CUBAS', 'finanza.prueba@credinica.com', '$2a$10$vZezx9h67Tf8FtD9rgf1z.Uq8Uxg5kdxixbcwgr0gBIxUrGGcqjaq', NULL, 'FINANZAS', NULL, 'TODAS', 1, 0, NULL, NULL, '2025-10-24 23:59:59', '2025-11-02 18:25:39'),
('user_1761708962918', 'HARWIN MANUEL RUEDA GESTOR', 'harwin.rueda@credinica.com', '$2a$10$TG7s9PUDyk2Cwe.dVxNCj.yrpCnVlw1SUTr2e6Vgk9T4QGV.HJ4.2', '5756-7451', 'GESTOR', 'suc_1761721008127', 'SUCURSAL PRINCIPAL', 1, 0, 'user_1761350279190', 'SUPERVISOR DE PRUEBA', '2025-10-29 03:36:03', '2025-11-24 05:15:51'),
('user_1762140989702', 'CRISTHIAN BOZA', 'cristhian@credinica.com', '$2a$10$znxLtvbXIOuwNOBEVnNDx.qQ1GfkUnFXvxKiFlhh55mUHqr2gjEBO', NULL, 'GERENTE', 'suc_1762140953432', 'SUCURSAL JINOTEPE', 1, 0, NULL, NULL, '2025-11-03 03:36:29', '2025-11-03 03:36:29'),
('user_admin_01', 'ADMINISTRADOR DEL SISTEMA', 'admin@credinica.com', '$2a$10$rGtXJaZ7LMFaIB6ujIa55uMkGq7MwUkQ2Kw8SS.jLJCBRmSHLE6Vy', NULL, 'ADMINISTRADOR', NULL, 'TODAS', 1, 0, NULL, NULL, '2025-10-24 22:25:14', '2025-10-25 00:00:29');

-- --------------------------------------------------------
-- FOREIGN KEYS
-- --------------------------------------------------------

ALTER TABLE `asalariado_info`
  ADD CONSTRAINT `fk_asalariado_client` FOREIGN KEY (`clientId`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

ALTER TABLE `clients`
  ADD CONSTRAINT `fk_client_sucursal` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursales` (`id`) ON DELETE SET NULL;

ALTER TABLE `closures`
  ADD CONSTRAINT `fk_closure_sucursal` FOREIGN KEY (`sucursalId`) REFERENCES `sucursales` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_closure_user` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;

ALTER TABLE `comerciante_info`
  ADD CONSTRAINT `fk_comerciante_client` FOREIGN KEY (`clientId`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

ALTER TABLE `credits`
  ADD CONSTRAINT `fk_credit_client` FOREIGN KEY (`clientId`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

ALTER TABLE `guarantees`
  ADD CONSTRAINT `fk_guarantee_credit` FOREIGN KEY (`creditId`) REFERENCES `credits` (`id`) ON DELETE CASCADE;

ALTER TABLE `guarantors`
  ADD CONSTRAINT `fk_guarantor_credit` FOREIGN KEY (`creditId`) REFERENCES `credits` (`id`) ON DELETE CASCADE;

ALTER TABLE `interactions`
  ADD CONSTRAINT `fk_interaction_client` FOREIGN KEY (`clientId`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

ALTER TABLE `payments_registered`
  ADD CONSTRAINT `fk_payment_credit` FOREIGN KEY (`creditId`) REFERENCES `credits` (`id`) ON DELETE CASCADE;

ALTER TABLE `payment_plan`
  ADD CONSTRAINT `fk_plan_credit` FOREIGN KEY (`creditId`) REFERENCES `credits` (`id`) ON DELETE CASCADE;

ALTER TABLE `personal_references`
  ADD CONSTRAINT `fk_reference_client` FOREIGN KEY (`clientId`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

ALTER TABLE `users`
  ADD CONSTRAINT `fk_user_sucursal` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursales` (`id`) ON DELETE SET NULL;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
