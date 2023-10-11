from libraries import *
from football_stats.get_prediction_data import get_table
from sklearn.ensemble import RandomForestRegressor
from sklearn.linear_model import LinearRegression


def predict(league, firstTeam, secondTeam):
    # got all data for training our model
    data_for_predict = get_table(league)

    # getting data for match between our teams ---
    first_predict = data_for_predict.loc[data_for_predict['first_title'] == firstTeam]
    first_predict = first_predict.drop(first_predict.iloc[:, 1: 3], axis=1)
    first_predict = first_predict.drop(first_predict.iloc[:, 11:], axis=1)
    first_predict = first_predict.iloc[0]
    first_predict = pd.DataFrame([first_predict])

    second_predict = data_for_predict.loc[data_for_predict['second_title'] == secondTeam]
    second_predict = second_predict.drop(second_predict.iloc[:, : 1], axis=1)
    second_predict = second_predict.drop(second_predict.iloc[:, 1: 12], axis=1)
    second_predict = second_predict.iloc[0]

    for x in second_predict.index:
        first_predict[x] = second_predict[x]
    final_predict = first_predict
    final_predict['result'] = 1
    frames = [data_for_predict, final_predict]
    main_result = pd.concat(frames)

    # ---

    def absolute_maximum_scale(series):
        return series / series.abs().max()

    train = main_result
    train = train.loc[:, train.columns != 'first_title']
    train = train.loc[:, train.columns != 'second_title']
    y_train = train['result']
    X_train = train.loc[:, train.columns != 'result']

    for col in X_train.columns:
        X_train[col] = absolute_maximum_scale(X_train[col])

    test = pd.DataFrame([X_train.iloc[-1]])
    X_test = test.loc[:, test.columns != 'result']

    reg = RandomForestRegressor(n_estimators=1000, random_state=0)
    clf = reg.fit(X_train, y_train)

    # lin_reg = LinearRegression().fit(X_train, y_train)
    # y_lin_hat = lin_reg.predict(X_test)

    answer = clf.predict(X_test)
    return json.dumps(str(round(answer.item(), 2)))
