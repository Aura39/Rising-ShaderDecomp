sampler g_AlbedoSampler : register(s0);
float4 g_CameraParam : register(c193);
sampler g_NormalSampler : register(s1);
float4 g_PointLightCol : register(c185);
float4 g_PointLightPos : register(c184);
float4x4 g_Proj : register(c4);
sampler g_ShadowSampler : register(s6);
float4 g_TargetUvParam : register(c194);
sampler g_ZSampler : register(s5);

float4 main(float4 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	r0.x = 1 / transpose(g_Proj)[0].x;
	r0.y = 1 / texcoord.w;
	r0.yz = r0.yy * texcoord.xy;
	r1.xy = float2(0.5, -0.5);
	r0.yz = r0.yz * r1.xy + g_TargetUvParam.xy;
	r0.yz = r0.yz + 0.5;
	r0.w = r0.y * 2 + -1;
	r1 = tex2D(g_ZSampler, r0.yzzw);
	r1.x = r1.x * g_CameraParam.y + g_CameraParam.x;
	r0.w = r0.w * r1.x;
	r2.x = r0.x * r0.w;
	r0.x = r0.z * -2 + 1;
	r0.x = r1.x * r0.x;
	r2.z = -r1.x;
	r0.w = 1 / transpose(g_Proj)[1].y;
	r2.y = r0.w * r0.x;
	r1.xyz = -r2.xyz + g_PointLightPos.xyz;
	r0.x = dot(r1.xyz, r1.xyz);
	r0.x = 1 / sqrt(r0.x);
	r1.xyz = r0.xxx * r1.xyz;
	r0.x = 1 / r0.x;
	r0.x = -r0.x + g_PointLightPos.w;
	r2 = tex2D(g_NormalSampler, r0.yzzw);
	r2.xyz = r2.xyz * 2 + -1;
	r0.w = r2.w + -0.495;
	r1.x = dot(r1.xyz, r2.xyz);
	r1.y = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.y;
	r1.yzw = r0.www * g_PointLightCol.xyz;
	r1.yzw = r1.xxx * r1.yzw;
	r1.x = r1.x + -0.5;
	r2.x = max(r1.x, 0);
	r1.x = 1 / g_PointLightCol.w;
	r0.x = r0.x * r1.x;
	r1.xyz = r0.xxx * r1.yzw;
	r3 = tex2D(g_AlbedoSampler, r0.yzzw);
	r4 = tex2D(g_ShadowSampler, r0.yzzw);
	r0.x = -r4.z + 1;
	r1.xyz = r1.xyz * r3.xyz;
	r0.y = r2.x + r3.w;
	r1.xyz = r0.yyy * r1.xyz;
	r1.xyz = (r0.www >= 0) ? r1.xyz : 0;
	r1.w = 1;
	o = r0.x * r1;

	return o;
}
