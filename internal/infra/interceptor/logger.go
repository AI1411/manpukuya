package interceptor

import (
	"context"
	"encoding/json"
	"log"
	"reflect"
	"time"

	"github.com/bufbuild/connect-go"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

// ZapLoggerInterceptor returns a new unary server interceptor for logging the execution of the unary handler
func ZapLoggerInterceptor(zapLogger *zap.Logger) connect.UnaryInterceptorFunc {
	interceptor := func(next connect.UnaryFunc) connect.UnaryFunc {
		return func(
			ctx context.Context,
			req connect.AnyRequest,
		) (connect.AnyResponse, error) {
			startTime := time.Now()

			traceID, _ := uuid.NewRandom()

			// trace_idでrequestとresponseを紐付ける
			loggerWithField := zapLogger.With(
				zap.String("trace_id", traceID.String()),
			)

			buffReq, _ := json.Marshal(req)
			jsonReq := map[string]interface{}{}
			_ = json.Unmarshal(buffReq, &jsonReq)

			loggerWithField.Info(
				"request",
				zap.String("grpc.start_time", startTime.Format(time.RFC3339Nano)),
				zap.Any("req", jsonReq),
			)

			res := ctx.Value("response")
			log.Println(res)
			buffRes, _ := json.Marshal(res)

			jsonRes := map[string]interface{}{}
			_ = json.Unmarshal(buffRes, &jsonRes)

			// エラーが発生した時もresponseとerrを表示したいので、この行でdefer実行
			defer loggerWithField.Info(
				"response",
				zap.String("grpc.end_time", time.Now().Format(time.RFC3339Nano)),
				zap.Int64("grpc.duration_nano", time.Since(startTime).Nanoseconds()),
				zap.Any("response", jsonRes),
			)
			return next(ctx, req)
		}
	}
	return interceptor
}

func contains(list interface{}, elem interface{}) bool {
	listV := reflect.ValueOf(list)

	if listV.Kind() == reflect.Slice {
		for i := 0; i < listV.Len(); i++ {
			item := listV.Index(i).Interface()
			// 型変換可能か確認する
			if !reflect.TypeOf(elem).ConvertibleTo(reflect.TypeOf(item)) {
				continue
			}
			// 型変換する
			target := reflect.ValueOf(elem).Convert(reflect.TypeOf(item)).Interface()
			// 等価判定をする
			if ok := reflect.DeepEqual(item, target); ok {
				return true
			}
		}
	}
	return false
}
