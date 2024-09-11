import 'dotenv/config';
import { migrate } from 'drizzle-orm/node-postgres/migrator';
import { db, client } from './db';
import { drizzle } from "drizzle-orm/node-postgres";
import pg from 'pg';

// This will run migrations on the database, skipping the ones already applied
await migrate(db, { migrationsFolder: './migratio' });

// Don't forget to close the connection, otherwise the script will hang
await client.end();
console.log("migrate")