import angular from 'angular';
import uirouter from 'angular-ui-router';
import dataTable from 'angular-material-data-table';

import CreateProfile from './createProfile';
import ProfileList from './profileList';
import Settings from './settings';

import styles from '../../assets/stylesheets/md-data-table.css';

export default angular.module('app.admin', [uirouter, CreateProfile, ProfileList, Settings, dataTable])
  .name;
