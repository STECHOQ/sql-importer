const mysql = require(`${__basedir}/lib/mariadb.class.js`);
mysql.setConfig(__config.db)


class generalTest{

    async checkRoutine(){
        return mysql.query(`
            SELECT 
                routine_name, 
                SUM(IF(routine_type = "FUNCTION", 0, 1)) as isFunction,
                SUM(IF(routine_type = "PROCEDURE", 0, 1)) as isProcedure
            FROM information_schema.routines 
            WHERE routine_schema = ?
            `,[__config.db.database])
            .then(res => {
    
                if(res[0].isFunction <= 0){
                    return false
                }
    
                if(res[0].isProcedure <= 0){
                    return false
                }
    
                return true
            })
            .catch(err => false)
    }
    
    async checkTable(){
        return mysql.query(`
        SELECT COUNT(table_name) as total FROM information_schema.tables
        WHERE table_schema = ? && table_name = "d_access_proposal"
        `,[__config.db.database])
        .then(res => {
            return res[0].total > 0 ? true: false
        })
        .catch(err => false)
    }
    
    async checkTableHasContent(){
        return mysql.query(`
        SELECT COUNT(1) as total FROM d_access_proposal
        `)
        .then(res => {
            return res[0].total > 0 ? true: false
        })
        .catch(err => false)
    }

    async checkTableHasLabCodeLT(){
        return mysql.query(`
        SELECT COUNT(1) as total FROM d_access_proposal WHERE labCode = "LT"
        `)
        .then(res => {
            return res[0].total > 0 ? true: false
        })
        .catch(err => false)
    }

    async checkTableHasItemCode(){
        return mysql.query(`
        SELECT COUNT(1) as total
        FROM information_schema.COLUMNS 
        WHERE 
            TABLE_SCHEMA = ?
        AND TABLE_NAME = 'd_access_proposal' 
        AND COLUMN_NAME = 'itemCode'
        `,[__config.db.database])
        .then(res => {
            return res[0].total > 0 ? true: false
        })
        .catch(err => false)
    }

    async checkTableHasItemCodeContent(){
        return mysql.query(`
        SELECT COUNT(1) as total FROM d_access_proposal where itemCode IS NOT NULL
        `)
        .then(res => {
            return res[0].total > 0 ? true: false
        })
        .catch(err => false)
    }


    async checkTableItem(){
        return mysql.query(`
        SELECT count(table_name) as total FROM information_schema.tables
        WHERE table_schema = ? && table_name = "d_item"
        `,[__config.db.database])
        .then(res => {
            return res[0].total > 0 ? true: false
        })
        .catch(err => false)
    }
    
    async checkTableItemHasContent(){
        return mysql.query(`
        SELECT COUNT(1) as total FROM d_item
        `)
        .then(res => {
            return res[0].total > 0 ? true: false
        })
        .catch(err => false)
    }

    async isStatusCodeChanged(){
        return mysql.query(`
        SELECT
        CONCAT(
            IF(column_type IS NULL, "", CONCAT(column_type, " ")), 
            IF(is_nullable = "YES", "NULL", "NOT NULL"), 
            IF(column_default IS NULL, "", CONCAT(" DEFAULT ", column_default))
        ) as curDetail
        FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = ? AND TABLE_NAME = "d_access_proposal" AND COLUMN_NAME = "statusCode";
        `,[__config.db.database])
        .then(res => {
            return res[0].curDetail == `text NULL DEFAULT 'NO NO'` ? true : false
        })
        .catch(err => false)
    }

    async isStatusCodeHasData(){
        return mysql.query(`
        SELECT SUM(IF(statusCode IS NOT NULL, 1, 0)) as total FROM d_access_proposal
        `)
        .then(res => {
            return res[0].total > 0 ? true: false
        })
        .catch(err => false)
        
    }



    async close(){
        try{
            await mysql.endAll();
        }catch(err){
            console.log(err)
        }
    }
}

module.exports = new generalTest()