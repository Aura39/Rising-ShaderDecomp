sampler g_Sampler0 : register(s13);
float4 g_TargetUvParam : register(c194);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0.xy = g_TargetUvParam.xy + texcoord.xy;
	r1.xy = float2(4, -4);
	r2 = g_TargetUvParam.xyxy * r1.xxyx + r0.xyxy;
	r3 = tex2D(g_Sampler0, r2);
	r2 = tex2D(g_Sampler0, r2.zwzw);
	r2 = r2 + r3;
	r0.zw = g_TargetUvParam.xy * r1.xy + r0.xy;
	r0.xy = g_TargetUvParam.xy * -r1.xx + r0.xy;
	r1 = tex2D(g_Sampler0, r0);
	r0 = tex2D(g_Sampler0, r0.zwzw);
	r0 = r0 + r2;
	r0 = r1 + r0;
	o = r0 * 0.25;

	return o;
}
