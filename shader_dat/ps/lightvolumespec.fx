sampler g_AlbedoSampler : register(s0);
float4 g_CameraParam : register(c193);
sampler g_NormalSampler : register(s1);
float4 g_PointLightCol : register(c185);
float4 g_PointLightPos : register(c184);
float4x4 g_Proj : register(c4);
sampler g_SpecMaskSampler : register(s2);
sampler g_SpecPowSampler : register(s3);
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
	float r5;
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
	r0.x = dot(-r2.xyz, -r2.xyz);
	r0.x = 1 / sqrt(r0.x);
	r1.xyz = -r2.xyz + g_PointLightPos.xyz;
	r0.w = dot(r1.xyz, r1.xyz);
	r0.w = 1 / sqrt(r0.w);
	r1.xyz = r0.www * r1.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + g_PointLightPos.w;
	r2.xyz = -r2.xyz * r0.xxx + r1.xyz;
	r3.xyz = normalize(r2.xyz);
	r2 = tex2D(g_NormalSampler, r0.yzzw);
	r2.xyz = r2.xyz * 2 + -1;
	r0.x = dot(r3.xyz, r2.xyz);
	r1.x = dot(r1.xyz, r2.xyz);
	r1.y = max(r0.x, 0);
	r0.x = -r1.y + 1;
	r3 = tex2D(g_SpecMaskSampler, r0.yzzw);
	r4 = tex2D(g_AlbedoSampler, r0.yzzw);
	r0.yz = r3.wz * float2(0.25, 100);
	r2.x = r0.x * -r0.y + r1.y;
	r0.x = r2.w + -0.495;
	r1.z = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r1.z;
	r1.z = max(r0.x, 0);
	r0.x = r1.z * -0.5 + r2.w;
	r3.xzw = r1.zzz * g_PointLightCol.xyz;
	r1.z = r0.x + -0.245;
	r1.w = (-r1.z >= 0) ? 0 : 1;
	r1.z = (r1.z >= 0) ? -0 : -1;
	r1.z = r1.z + r1.w;
	r2.z = max(r1.z, 0);
	r0.x = r2.z * -0.25 + r0.x;
	r4.xyz = r2.zzz + r4.xyz;
	r2.y = r0.x * 4;
	r2 = tex2D(g_SpecPowSampler, r2);
	r2.w = pow(r1.y, r0.y);
	r0.x = (-r1.x >= 0) ? 0 : 1;
	r0.y = (-r1.y >= 0) ? 0 : r0.x;
	r0.x = r1.x * r0.x;
	r1.x = r1.x + -0.5;
	r5.x = max(r1.x, 0);
	r1.x = r4.w + r5.x;
	r0.y = r2.w * r0.y;
	r1.yzw = r0.xxx * -r0.yyy + r2.xyz;
	r0.x = r0.y * r0.x;
	r1.yzw = r3.yyy * r1.yzw + r0.xxx;
	r1.yzw = r1.yzw * r3.xzw;
	r0.xyz = r0.zzz * r1.yzw;
	r1.y = 1 / g_PointLightCol.w;
	r0.w = r0.w * r1.y;
	r0.xyz = r0.www * r0.xyz;
	r0.xyz = r4.xyz * r0.xyz;
	o.xyz = r1.xxx * r0.xyz;
	o.w = 1;

	return o;
}
