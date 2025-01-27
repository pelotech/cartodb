/**
 * Configuration required for statics pages at frontend assets compilation¡
 * See its use from /webpack/static-pages/
 *
 * Note: don't modify its contents unless it's coordinated to work with deployments in different environments
 */

const CARTO_BUILDER_ASSET_HOST = JSON.stringify(process.env.CARTO_BUILDER_ASSET_HOST || '/assets');
const CARTO_MAPS_API_V2_EXTERNAL_URL = JSON.stringify(process.env.CARTO_MAPS_API_V2_EXTERNAL_URL || 'http://localhost.lan:8282');

module.exports = {
  'CARTO_BUILDER_ASSET_HOST': CARTO_BUILDER_ASSET_HOST,
  'CARTO_MAPS_API_V2_EXTERNAL_URL': CARTO_MAPS_API_V2_EXTERNAL_URL
};
