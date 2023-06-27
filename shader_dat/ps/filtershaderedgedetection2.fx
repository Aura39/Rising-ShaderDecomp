float4 g_CameraParam;
sampler g_Sampler0;
sampler g_Sampler1;
float4 g_TargetUvParam;
float4 g_param;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float3 r5;
	r0.xy = g_TargetUvParam.xy;
	r0 = r0.xyxy * float4(-1, 1, 1, -1);
	r1.x = g_param.y;
	r2.x = 0;
	r1.x = (-r1.x >= 0) ? r2.x : g_param.y;
	r1.yz = g_TargetUvParam.xy + texcoord.xy;
	r0 = r0 * r1.x + r1.yzyz;
	r2 = tex2D(g_Sampler0, r0);
	r0 = tex2D(g_Sampler0, r0.zwzw);
	r3.xy = g_TargetUvParam.xy * r1.xx + r1.yz;
	r1.xw = -g_TargetUvParam.xy * r1.xx + r1.yz;
	r4 = tex2D(g_Sampler1, r1.yzzw);
	r0.w = r4.x * g_CameraParam.y + g_CameraParam.x;
	r1 = tex2D(g_Sampler0, r1.xwzw);
	r3 = tex2D(g_Sampler0, r3);
	r4.xyz = -r2.xyz + r3.xyz;
	r4.xyz = r4.xyz * r4.xyz;
	r5.xyz = -r1.xyz + r3.xyz;
	r3.xyz = -r0.xyz + r3.xyz;
	r4.xyz = r5.xyz * r5.xyz + r4.xyz;
	r3.xyz = r3.xyz * r3.xyz + r4.xyz;
	r4.xyz = -r2.xyz + r1.xyz;
	r1.xyz = -r0.xyz + r1.xyz;
	r0.xyz = -r0.xyz + r2.xyz;
	r2.xyz = r4.xyz * r4.xyz + r3.xyz;
	r1.xyz = r1.xyz * r1.xyz + r2.xyz;
	r0.xyz = r0.xyz * r0.xyz + r1.xyz;
	r0.x = r0.y + r0.x;
	r0.x = r0.z + r0.x;
	r0.y = r0.w * 0.12;
	r0.z = r0.w * -0.2 + 1;
	r1.x = max(0.4, r0.z);
	r0.x = r0.x * 3 + -r0.y;
	r0.y = r0.x * g_param.x;
	r2.x = g_param.x;
	r0.x = r0.x * r2.x + -0.3;
	r0.y = r1.x * r0.y;
	o.w = (-r0.x >= 0) ? 0 : r0.y;
	o.xyz = 0;

	return o;
}
