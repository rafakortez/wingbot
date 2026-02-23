export const config = {
  PORT: 443,
  DEBUG_LEVEL: 'normal', // Options: 'normal', 'verbose' 
  SERVER_IP: '138.197.231.228',
  ALLOWED_IPS: [
    '52.89.214.238',
    '34.212.75.30',
    '54.218.53.128',
    '52.32.178.7',
    '138.197.231.228',
    '192.81.216.8',
    '179.0.56.238',
    '143.110.222.166',
    '177.107.124.117',
    '::ffff:95.214.53.205',
    '127.0.0.1',
    '::ffff:127.0.0.1',
    '::1'
  ],

  SIMPLEFX_API_KEY: 'YOUR_API_KEY',
  SIMPLEFX_API_SECRET: 'YOUR_API_SECRET',

  SIMPLEFX_API_KEY2: 'YOUR_API_KEY2',
  SIMPLEFX_API_SECRET2: 'YOUR_API_SECRET2',

  SIMPLEFX_API_URL: 'https://rest.simplefx.com/api/v3',
  SIMPLEFX_QUOTES_URL: 'https://web-quotes-core.simplefx.com',

  // Circuit breaker parameters
  CIRCUIT_BREAKER: {
    FAILURE_THRESHOLD: 5,
    RESET_TIMEOUT: 60000, // 1 minute in milliseconds
    HALF_OPEN_TIMEOUT: 30000 // 30 seconds in milliseconds
  },

  // Rate limiting parameters
  RATE_LIMIT: {
    MAX_REQUESTS: 10,
    TIME_WINDOW: 60000 // 1 minute in milliseconds
  },

  BYBIT_API_KEY: 'YOUR_BYBIT_KEY',
  BYBIT_API_SECRET: 'YOUR_BYBIT_SECRET',
  BYBIT_TESTNET: true,

  BYBIT: {
    API_KEY: 'YOUR_BYBIT_KEY',
    API_SECRET: 'YOUR_BYBIT_SECRET',
    TESTNET: true,
  },

  STATUS_AUTH: {
    USERNAME: 'admin',
    PASSWORD: 'YOUR_PASSWORD'
  },

  STATUS_AUTH2: {
    USERNAME: 'admin',
    PASSWORD: 'YOUR_PASSWORD'
  },

  // Cron job configuration
  CRON: {
    // Order sync interval in minutes (set to 0 to disable)
    ORDER_SYNC_INTERVAL: parseInt(process.env.ORDER_SYNC_INTERVAL || '30'),
    // Enable/disable order sync cron
    ENABLE_ORDER_SYNC: process.env.ENABLE_ORDER_SYNC !== 'false'
  },

  // Spread limits configuration
  SPREAD_LIMITS: {
    forex: {
      normal: 15,      // pips during normal market conditions
      news: 25,        // pips during news events (higher volatility)
      overnight: 20,   // pips during low liquidity hours
      lowVolatility: 8 // pips during very low volatility (tighter spreads required)
    },
    indices: {
      normal: 300,     // points during normal market conditions
      news: 500,       // points during news events
      overnight: 400,  // points during low liquidity hours
      lowVolatility: 150 // points during very low volatility
    }
  },

  // Spread validation settings
  SPREAD_VALIDATION: {
    maxRetries: 5,           // Maximum retry attempts when spread is too high
    retryDelayMs: 2000,      // Delay between retries in milliseconds
    backoffMultiplier: 1.5   // Exponential backoff multiplier
  }
};

// export const DEFAULT_ACCOUNT_NUMBER2 = '3979937';
export const DEFAULT_ACCOUNT_NUMBER = '3028761';

// Account configuration
// export const SECONDARY_API_ACCOUNTS = [DEFAULT_ACCOUNT_NUMBER2]; // Accounts that use the secondary API - DISABLED
export const SECONDARY_API_ACCOUNTS: string[] = []; // No secondary API accounts - all use primary
export const ALL_MONITORED_ACCOUNTS = [DEFAULT_ACCOUNT_NUMBER, '3028450']; // All accounts to monitor

// Environment variable validation - REMOVED since using hardcoded values