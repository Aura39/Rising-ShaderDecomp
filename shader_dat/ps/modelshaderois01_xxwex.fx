sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
samplerCUBE cubemap_sampler : register(s2);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 muzzle_light : register(c69);
float4 muzzle_lightpos : register(c70);
sampler normalmap_sampler : register(s3);
float4 point_light1 : register(c63);
float4 point_lightpos1 : register(c64);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
float4 tile : register(c43);
sampler tripleMask_sampler : register(s1);
float4x4 viewInverseMatrix : register(c12);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
	float3 texcoord5 : TEXCOORD5;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1 = r0.w + -0.8;
	clip(r1);
	r0.w = 1 / i.texcoord7.w;
	r1.xy = r0.ww * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(Shadow_Tex_sampler, r1);
	r0.w = r1.z + g_ShadowUse.x;
	r1.x = -r0.w + 1;
	r1.yz = -r0.yy + r0.xz;
	r2.x = max(abs(r1.y), abs(r1.z));
	r1.y = r2.x + -0.015625;
	r1.z = (-r1.y >= 0) ? 0 : 1;
	r1.y = (r1.y >= 0) ? -0 : -1;
	r1.y = r1.y + r1.z;
	r1.y = (r1.y >= 0) ? -r1.y : -0;
	r0.xz = (r1.yy >= 0) ? r0.yy : r0.xz;
	r1.yzw = r0.xyz * i.texcoord5.xyz;
	r1.xyz = r1.xxx * r1.yzw;
	r2.xyz = r0.xyz * ambient_rate.xyz;
	r1.xyz = r2.xyz * ambient_rate_rate.xyz + r1.xyz;
	r2.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r3.xyz = normalize(r2.xyz);
	r2.xyz = i.texcoord3.xyz;
	r4.xyz = r2.yzx * i.texcoord2.zxy;
	r2.xyz = i.texcoord2.yzx * r2.zxy + -r4.xyz;
	r4.xy = tile.xy;
	r4.xy = i.texcoord.xy * r4.xy + g_All_Offset.xy;
	r4 = tex2D(normalmap_sampler, r4);
	r4.xyz = r4.xyz + -0.5;
	r2.xyz = r2.xyz * -r4.yyy;
	r1.w = r4.x * i.texcoord2.w;
	r2.xyz = r1.www * i.texcoord2.xyz + r2.xyz;
	r2.xyz = r4.zzz * i.texcoord3.xyz + r2.xyz;
	r4.xyz = normalize(r2.xyz);
	r1.w = dot(r3.xyz, r4.xyz);
	r2.xyz = r1.www * point_light1.xyz;
	r2.xyz = r2.xyz * i.texcoord8.xxx;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r5.xyz = normalize(r3.xyz);
	r1.w = dot(r5.xyz, r4.xyz);
	r3.xyz = r1.www * muzzle_light.xyz;
	r2.xyz = r3.xyz * i.texcoord8.zzz + r2.xyz;
	r1.w = dot(lightpos.xyz, r4.xyz);
	r2.w = r1.w;
	r3.xyz = r2.www * light_Color.xyz;
	r2.xyz = r3.xyz * r0.www + r2.xyz;
	r2.xyz = r0.xyz * r2.xyz;
	r3.xy = tile.xy * i.texcoord.xy;
	r3 = tex2D(tripleMask_sampler, r3);
	r2.xyz = r2.xyz * r3.www;
	r3.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.w = r1.w + -r3.x;
	r1.w = r1.w + 1;
	r1.xyz = r1.xyz * r1.www + r2.xyz;
	r2.x = dot(r4.xyz, transpose(viewInverseMatrix)[0].xyz);
	r2.y = dot(r4.xyz, transpose(viewInverseMatrix)[1].xyz);
	r2.z = dot(r4.xyz, transpose(viewInverseMatrix)[2].xyz);
	r1.w = dot(i.texcoord4.xyz, r2.xyz);
	r1.w = r1.w + r1.w;
	r5.xyz = r2.xyz * -r1.www + i.texcoord4.xyz;
	r5.w = -r5.z;
	r5 = tex2D(cubemap_sampler, r5.xyww);
	r5 = r5 * ambient_rate_rate.w;
	r5.xyz = r3.yyy * r5.xyz;
	r1.w = r2.w * 0.5 + 0.5;
	r5 = r1.w * r5;
	r1.w = r5.w * CubeParam.y + CubeParam.x;
	r2.xyz = r1.www * r5.xyz;
	r3.xyw = r0.xyz * r2.xyz;
	r0.xyz = r0.xyz + specularParam.www;
	r5.xyz = r3.xyw * CubeParam.zzz + r1.xyz;
	r3.xyw = r3.xyw * CubeParam.zzz;
	r1.xyz = r1.xyz * -r3.xyw + r5.xyz;
	r1.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r3.xyw = -i.texcoord1.xyz * r1.www + lightpos.xyz;
	r5.xyz = normalize(r3.xyw);
	r1.w = dot(r5.xyz, r4.xyz);
	r3.x = pow(r1.w, specularParam.z);
	r3.y = (-r2.w >= 0) ? 0 : 1;
	r2.w = r2.w * r3.y;
	r1.w = (-r1.w >= 0) ? 0 : r3.y;
	r1.w = r3.x * r1.w;
	r3.xyw = r2.www * light_Color.xyz;
	r3.xyw = r1.www * r3.xyw;
	r3.xyz = r3.zzz * r3.xyw;
	r3.xyz = r0.www * r3.xyz;
	r0.w = abs(specularParam.x);
	r3.xyz = r0.www * r3.xyz;
	r0.xyz = r3.xyz * r0.xyz + r1.xyz;
	r1.y = 1;
	r0.w = r1.y + -CubeParam.z;
	r0.xyz = r2.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
