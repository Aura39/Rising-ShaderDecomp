sampler g_AlbedoSampler : register(s0);
float4 g_CameraParam : register(c193);
sampler g_NormalSampler : register(s1);
sampler g_NormalSampler2 : register(s8);
float4x4 g_Proj : register(c4);
sampler g_SignSampler : register(s7);
float4 g_SpotLightCol : register(c185);
float4 g_SpotLightPos : register(c184);
float4 g_TargetUvParam : register(c194);
sampler g_ZSampler : register(s5);
float4 g_lightHosei : register(c174);
float4 g_lightHosei2 : register(c175);
float4 g_otherParam : register(c188);
float4 g_spot_angle : register(c186);
float4 g_spot_param : register(c187);

float4 main(float4 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	r0.x = 1 / texcoord.w;
	r0.xy = r0.xx * texcoord.xy;
	r1.xy = float2(0.5, -0.5);
	r0.xy = r0.xy * r1.xy + g_TargetUvParam.xy;
	r0.xy = r0.xy + 0.5;
	r1 = tex2D(g_SignSampler, r0);
	r2 = r1 + 0.5;
	r3 = frac(r2);
	r2 = r2 + -r3;
	r0.zw = r2.yw * float2(1.5, 4);
	r3 = -r1 + 1.5;
	r4 = frac(r3);
	r3 = r3 + -r4;
	r0.zw = r3.yw * 3 + r0.zw;
	r2.xy = r2.xz * 2 + r3.xz;
	r3 = frac(-r1);
	r1 = r1 + r3;
	r0.zw = r0.zw * r1.yw;
	r0.zw = r2.xy * r1.xz + r0.zw;
	r1 = r0.z + float4(-2, -3, -4, -1);
	r0.z = r0.w + -g_lightHosei2.y;
	r2 = r1.w;
	clip(r2);
	r3.xy = float2(-0.1, 0.9);
	r0.w = (g_lightHosei2.y >= 0) ? r3.x : r3.y;
	r3 = (-abs(r0.z) >= 0) ? 0.9 : r0.w;
	clip(r3);
	r0.z = 1 / transpose(g_Proj)[0].x;
	r0.w = r0.x * 2 + -1;
	r3 = tex2D(g_ZSampler, r0);
	r1.w = r3.x * g_CameraParam.y + g_CameraParam.x;
	r0.w = r0.w * r1.w;
	r3.x = r0.z * r0.w;
	r0.z = r0.y * -2 + 1;
	r0.z = r1.w * r0.z;
	r3.z = -r1.w;
	r0.w = 1 / transpose(g_Proj)[1].y;
	r3.y = r0.w * r0.z;
	r2.yzw = -r3.xyz + g_SpotLightPos.xyz;
	r0.z = dot(r2.yzw, r2.yzw);
	r0.z = 1 / sqrt(r0.z);
	r2.yzw = r0.zzz * r2.yzw;
	r0.z = 1 / r0.z;
	r0.z = r0.z * g_otherParam.z;
	r0.z = -r0.z + 1;
	r0.z = r0.z * g_otherParam.w;
	r0.w = dot(r2.yzw, g_spot_angle.xyz);
	r1.w = r0.w + -g_spot_param.x;
	r2.y = r1.w;
	r1.w = r1.w * g_spot_angle.w;
	r1.w = r1.w * g_otherParam.y;
	r3 = tex2D(g_NormalSampler, r0);
	r2.z = r3.y * 0.003921569 + r3.x;
	r3.x = r3.z * 1.53787E-05 + r2.z;
	r2.z = r3.w + -0.495;
	r4 = tex2D(g_NormalSampler2, r0);
	r5 = tex2D(g_AlbedoSampler, r0);
	r0.x = r4.y * 0.003921569 + r4.x;
	r3.y = r4.z * 1.53787E-05 + r0.x;
	r3.z = r4.w;
	r3.xyz = r3.xyz * 2 + -1;
	r4.xyz = normalize(r3.xyz);
	r0.x = dot(g_spot_angle.xyz, r4.xyz);
	r0.x = (-r2.y >= 0) ? 0 : r0.x;
	r0.y = r0.x * 0.5;
	r0.y = r0.w * 0.5 + r0.y;
	r0.w = frac(-r0.x);
	r0.x = r0.w + r0.x;
	r0.x = r0.x * r0.y;
	r0.x = r1.w * r0.x;
	r0.x = r0.z * r0.x;
	r0.y = lerp(g_lightHosei.y, g_lightHosei.x, r2.x);
	r1.xyz = r1.xyz;
	r0.y = (-r1.x >= 0) ? r0.y : g_lightHosei.z;
	r0.y = (-r1.y >= 0) ? r0.y : g_lightHosei.w;
	r0.y = (-r1.z >= 0) ? r0.y : g_lightHosei2.x;
	r0.yzw = r0.yyy * g_SpotLightCol.xyz;
	r1.x = (-r2.z >= 0) ? 0 : 1;
	r1.y = (r2.z >= 0) ? -0 : -1;
	r1.x = r1.y + r1.x;
	r0.yzw = r0.yzw * r1.xxx;
	r0.yzw = r0.xxx * r0.yzw;
	r0.x = r0.x + r5.w;
	r0.yzw = r0.yzw * r5.xyz;
	r0.xyz = r0.xxx * r0.yzw;
	o.xyz = (r1.xxx >= 0) ? r0.xyz : 0;
	o.w = 1;

	return o;
}
