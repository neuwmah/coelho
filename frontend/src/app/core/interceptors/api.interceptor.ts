import { HttpInterceptorFn } from '@angular/common/http';

export const apiInterceptor: HttpInterceptorFn = (req, next) => {
  const cloned = req.clone({
    setHeaders: {
      Accept: 'application/json',
      'Content-Type': 'application/json'
    }
  });

  return next(cloned);
};
