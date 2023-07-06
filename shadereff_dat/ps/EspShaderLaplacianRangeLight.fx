float4 g_BlendColor;
float4 g_CameraParam;
float4 g_Center;
float4 g_MatrialColor;
float4 g_Range;
sampler g_Sampler0;
float4 g_TargetUvParam;

float4 main(float4 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0.x = 1 / texcoord.w;
	r0.xy = r0.xx * texcoord.xy;
	r0.xy = r0.xy * 0.5 + 0.5;
	r0.z = -r0.y + 1;
	r1.xy = float2(3, 100);
	r1.xz = g_TargetUvParam.xy * r1.xx + r0.xz;
	r0.zw = r0.xz + g_TargetUvParam.xy;
	r0.xy = r0.xy * 2 + -1;
	r2 = tex2D(g_Sampler0, r0.zwzw);
	r3 = tex2D(g_Sampler0, r1.xzzw);
	r0.z = r3.x * -r1.y + g_Range.y;
	r0.w = r3.x * 100;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r1.x = r2.x * -r1.y + g_Range.y;
	r1.x = (r1.x >= 0) ? 1 : 0;
	r0.z = r0.z + r1.x;
	r0.z = -r0.z + 0.5;
	r1.x = r2.x * 100;
	r0.z = (r0.z >= 0) ? r1.x : r0.w;
	r2.y = min(r0.z, r1.x);
	r0.z = r2.x * -100 + r0.z;
	r0.w = r2.x * g_CameraParam.y + g_CameraParam.x;
	r0.z = abs(r0.z) + -g_Center.w;
	r1.x = r2.y + -g_Range.z;
	r1.y = 1;
	r1.x = r1.x * -g_Range.w + r1.y;
	r2 = g_BlendColor;
	r2 = -r2 + g_MatrialColor;
	r1 = r1.x * r2;
	r1 = (r0.z >= 0) ? r1 : 0;
	r1 = r1 + g_BlendColor;
	r0.xy = r0.ww * r0.xy;
	r2.z = -r0.w;
	r2.xy = r0.xy * g_CameraParam.zw;
	r0.xyz = -r2.xyz + g_Center.xyz;
	r0.x = dot(r0.xyz, r0.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.x = 1 / r0.x;
	r0.x = r0.x + -g_Range.x;
	o.w = (r0.x >= 0) ? r1.w : 0;
	o.xyz = r1.xyz;

	return o;
}
