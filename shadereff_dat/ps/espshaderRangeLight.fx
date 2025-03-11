float4 g_CameraParam : register(c193);
float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
float4 g_Rate2 : register(c186);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
float4 g_TargetUvParam : register(c194);
float4 g_ViewPos : register(c187);

float4 main(float4 texcoord1 : TEXCOORD1) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = 1 / texcoord1.w;
	r0.xy = r0.xx * texcoord1.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.zw = r0.xy + g_TargetUvParam.xy;
	r1 = tex2D(g_Sampler1, r0.zwzw);
	r0.z = r1.x * g_CameraParam.y + g_CameraParam.x;
	r1.xy = r0.xy * float2(2, -2) + float2(-1, 1);
	r0.xy = r0.xy * g_Rate2.ww;
	r2 = tex2D(g_Sampler0, r0);
	r0.xy = r0.zz * r1.xy;
	r1.z = -r0.z;
	r1.xy = r0.xy * g_CameraParam.zw;
	r0.xyz = -r1.xyz + g_ViewPos.xyz;
	r0.x = dot(r0.xyz, r0.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.x = 1 / r0.x;
	r0.z = 1;
	r0.y = r0.x * -g_Rate.x + r0.z;
	r0.x = r0.x * g_Rate.x + -g_Rate.y;
	r0.x = abs(r0.x) * -g_Rate.z + r0.z;
	r0.w = g_Rate.w;
	r0.x = (r0.x >= 0) ? r0.w : 0;
	r0.y = r0.y * 5;
	r1.x = max(r0.y, 0);
	r0.y = min(r1.x, 0.3);
	r0 = r0.y * r2 + r0.x;
	o = r0 * g_MatrialColor;

	return o;
}
