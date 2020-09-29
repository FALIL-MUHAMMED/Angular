import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';


const routes: Routes = [
  { 
    path: '', loadChildren: () => import('./modules/pages/signup/signup.module').then(m => m.SignupModule) 
  },
  { path: 'home', loadChildren: () => import('./modules/pages/home/home.module').then(m => m.HomeModule) },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
